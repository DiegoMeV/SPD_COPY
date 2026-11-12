import { writeFileSync } from "fs";
import { resolve } from "path";
import { OracleDBClient } from "../lib/oracle";
import { toCamelCase, toClassName } from "../lib/utils";
import { Command } from "commander";

interface ColumnMetadata {
  COLUMN_NAME: string;
  DATA_TYPE: string;
  NULLABLE: string;
  DATA_PRECISION: number | null;
  DATA_SCALE: number | null;
}

const getTableMetadata = async (client: OracleDBClient, tableName: string) => {
  const query = `
    SELECT column_name, data_type, nullable, data_precision, data_scale
    FROM all_tab_columns
    WHERE table_name = UPPER(:tableName)
    ORDER BY column_id
  `;

  const result = await client.executeQuery(query, { tableName });
  return result as ColumnMetadata[];
};

const mapOracleTypeToGraphQLType = (
  oracleType: string,
  precision: number | null,
  scale: number | null,
  preferredNumberType: "Int" | "Float",
): { gqlType: string; tsType: string } => {
  if (oracleType === "NUMBER") {
    if (scale === null && precision === null) {
      return { gqlType: preferredNumberType ?? "Int", tsType: "number" };
    } else if (scale === 0) {
      return { gqlType: "Int", tsType: "number" };
    } else {
      return { gqlType: "Float", tsType: "number" };
    }
  }
  switch (oracleType) {
    case "VARCHAR2":
    case "CHAR":
    case "CLOB":
      return { gqlType: "String", tsType: "string" };
    case "DATE":
    case "TIMESTAMP":
      return { gqlType: "Date", tsType: "Date" };
    default:
      return { gqlType: "String", tsType: "string" };
  }
};

const generateField = (col: ColumnMetadata, preferredNumberType: "Int" | "Float") => {
  const { gqlType, tsType } = mapOracleTypeToGraphQLType(
    col.DATA_TYPE,
    col.DATA_PRECISION,
    col.DATA_SCALE,
    preferredNumberType,
  );
  const isNullable = col.NULLABLE === "Y";
  const nullable = isNullable ? ", { nullable: true }" : "";
  return `  @Field(() => ${gqlType}${nullable})\n  ${toCamelCase(col.COLUMN_NAME)}${isNullable ? "?" : "!"}: ${tsType}${nullable ? " | null" : ""};`;
};

const generateClassFile = (
  tableName: string,
  columns: ColumnMetadata[],
  preferredNumberType: "Int" | "Float",
  outDir?: string,
) => {
  const className = toClassName(tableName);
  const fields = columns.map((col) => generateField(col, preferredNumberType)).join("\n\n");

  const fieldTypesImport: string[] = [];
  if (/ Int/g.test(fields)) fieldTypesImport.push("Int");
  if (/ Float/g.test(fields)) fieldTypesImport.push("Float");

  const classTemplate = `
  import { ObjectType, Field${fieldTypesImport.length ? ", " + fieldTypesImport.join(", ") : ""} } from 'type-graphql';
  
  @ObjectType()
  export class ${className} {
  ${fields}
  }
  `;

  const filePath = resolve(__dirname, `${outDir ?? "./output"}/${toCamelCase(tableName)}.ts`);
  writeFileSync(filePath, classTemplate);
  console.log(`Generated ${filePath}`);
};

const generateModel = async (
  client: OracleDBClient,
  tableName: string,
  preferredNumberType: "Int" | "Float",
  outDir?: string,
) => {
  try {
    const columns = await getTableMetadata(client, tableName);

    generateClassFile(tableName, columns, preferredNumberType, outDir);
  } catch (err) {
    console.error(err);
  }
};

const main = async ({
  tenantKey,
  tableName,
  tableNames,
  outDir,
  preferredNumberType,
}: {
  tenantKey: string;
  tableName?: string;
  tableNames?: string;
  outDir?: string;
  preferredNumberType: "Int" | "Float";
}) => {
  if (!tableName && !tableNames) {
    console.error("Please provide a table name using --table or --tables");
    process.exit(1);
  }
  const client = new OracleDBClient({ tenantKey });
  const tables = (tableNames?.split(",") ?? [tableName]) as string[];

  for (const table of tables) {
    await generateModel(client, table, preferredNumberType, outDir);
  }
};

const program = new Command();

program
  .name("generate-oracle-models")
  .description("Generate a TypeGraphQL class from Oracle tables")
  .version("1.0.0")
  .option("--table <tableName>", "Name of the Oracle table")
  .option("--tables <tableNames>", "Name of the Oracle tables, separated by comma")
  .option("--tenantKey <tenantKey>", "Key of the tenant to connect to Oracle DB")
  .option("--outDir <outDir>", "Directory to output the generated files")
  .option(
    "--preferredNumberType <preferredNumberType>",
    "Preferred Number Type (Int or Float). Default is Int.",
  )
  .action((options) => {
    if (!options.table && !options.tables) {
      console.error("Please provide a table name using --table or --tables");
      process.exit(1);
    }
    if (!options.tenantKey) {
      console.error("Please provide a tenantKey name using --tenantKey");
      process.exit(1);
    }
    main({
      tenantKey: options.tenantKey,
      tableName: options.table,
      tableNames: options.tables,
      outDir: options.outDir,
      preferredNumberType: options.preferredNumberType ?? "Int",
    });
  });

program.parse(process.argv);
