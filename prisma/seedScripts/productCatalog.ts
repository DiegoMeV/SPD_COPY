import { PrismaClient } from "@prisma/client";
import * as path from "path";
import * as csv from "fast-csv";
import _ from "lodash";

const prisma = new PrismaClient();

type ProductCatalogCsv = {
  sector: string;
  sector_name: string;
  program: string;
  program_name: string;
  product_code: string;
  product_name: string;
  product_description: string;
  product_units: string;
  indicator_code: string;
  indicator_name: string;
  indicator_units: string;
  is_principal: string;
  is_national: string;
  is_territorial: string;
};

type ProductCatalogRow = {
  sector: string;
  sectorName: string;
  program: string;
  programName: string;
  productCode: string;
  productName: string;
  productDescription: string;
  productUnits: string;
  indicatorCode: string;
  indicatorName: string;
  indicatorUnits: string;
  isPrincipal: boolean;
  isNational: boolean;
  isTerritorial: boolean;
};

function parseProductCatalog(
  path: string,
  rowProcessor: (row: ProductCatalogCsv) => ProductCatalogRow,
): Promise<ProductCatalogRow[]> {
  return new Promise((resolve, reject) => {
    const data: ProductCatalogRow[] = [];
    csv
      .parseFile(path, { headers: true, delimiter: "\t" })
      .on("error", reject)
      .on("data", (row) => {
        data.push(rowProcessor(row));
      })
      .on("end", () => {
        resolve(data);
      });
  });
}

async function seedProductCatalogSectors(data: ProductCatalogRow[]) {
  const sectors: Record<string, string> = {};
  data.forEach((row) => {
    if (!sectors[row.sector]) sectors[row.sector] = row.sectorName;
  });

  const result = await prisma.productCatalog.createMany({
    data: Object.entries(sectors).map(([k, v]) => ({
      code: k,
      name: v,
    })),
  });
  console.log(`[seedProductCatalog] Number of product catalog sectors created: ${result.count}`);
}

async function seedProductCatalogPrograms(data: ProductCatalogRow[]) {
  const programs: Record<string, Record<string, string>> = {};
  const dbSectors = await prisma.productCatalog.findMany({ where: { parentId: null } });
  const getSector = (code: string) => dbSectors.find((sector) => sector.code === code);

  data.forEach((row) => {
    if (!programs[row.program])
      programs[row.program] = {
        code: row.program,
        name: row.programName,
        sectorCode: row.sector,
      };
  });

  const result = await prisma.productCatalog.createMany({
    data: Object.entries(programs).map(([k, v]) => ({
      code: v.code,
      name: v.name,
      parentId: getSector(v.sectorCode)?.id,
    })),
  });
  console.log(`[seedProductCatalog] Number of product catalog programs created: ${result.count}`);
}

async function seedProductCatalogProducts(data: ProductCatalogRow[]) {
  const products: Record<string, Record<string, string>> = {};
  const dbPrograms = await prisma.productCatalog.findMany({ where: { parentId: { not: null } } });
  const getProgram = (code: string) => dbPrograms.find((program) => program.code === code);

  data.forEach((row) => {
    if (!products[row.productCode])
      products[row.productCode] = {
        code: row.productCode,
        name: row.productName,
        description: row.productDescription,
        unitsName: row.productUnits,
        programCode: row.program,
      };
  });

  const result = await prisma.productCatalog.createMany({
    data: Object.values(products).map((v) => ({
      code: v.code,
      name: v.name,
      description: v.description,
      unitsName: v.unitsName,
      parentId: getProgram(v.programCode)?.id,
    })),
  });
  console.log(`[seedProductCatalog] Number of product catalog products created: ${result.count}`);
}

async function seedProductCatalogIndicators(data: ProductCatalogRow[]) {
  const indicators: Record<
    string,
    {
      code: string;
      name: string;
      unitsName: string;
      isPrincipal: boolean;
      isNational: boolean;
      isTerritorial: boolean;
      productCode: string;
    }
  > = {};
  const dbProducts = await prisma.productCatalog.findMany({
    where: { parentProductCatalog: { parentProductCatalog: { parentId: null } } },
  });
  const getProduct = (code: string) => dbProducts.find((product) => product.code === code);

  data.forEach((row) => {
    if (!indicators[row.indicatorCode])
      indicators[row.indicatorCode] = {
        code: row.indicatorCode,
        name: row.indicatorName,
        unitsName: row.indicatorUnits,
        isPrincipal: row.isPrincipal,
        isNational: row.isNational,
        isTerritorial: row.isTerritorial,
        productCode: row.productCode,
      };
  });

  const result = await prisma.productCatalog.createMany({
    data: Object.values(indicators).map((v) => {
      const { productCode, ...values } = v;
      return {
        ...values,
        isLeaf: true,
        parentId: getProduct(productCode)?.id,
      };
    }),
  });
  console.log(`[seedProductCatalog] Number of product catalog indicators created: ${result.count}`);
}

async function seedProductCatalog() {
  const dbProducts = await prisma.productCatalog.findMany();
  if (!dbProducts?.length) {
    const data = await parseProductCatalog(
      path.resolve(__dirname, "../seedData/common", "product_catalog.csv"),
      (row) => ({
        sector: row.sector,
        sectorName: row.sector_name,
        program: row.program,
        programName: row.program_name,
        productCode: row.product_code,
        productName: row.product_name,
        productDescription: row.product_description,
        productUnits: row.product_units,
        indicatorCode: row.indicator_code,
        indicatorName: row.indicator_name,
        indicatorUnits: row.indicator_units,
        isPrincipal: row.is_principal === "SI",
        isNational: row.is_national === "SI",
        isTerritorial: row.is_territorial === "SI",
      }),
    );
    console.log(`[seedProductCatalog] Number of product catalog rows to create: ${data.length}`);
    await seedProductCatalogSectors(data);
    await seedProductCatalogPrograms(data);
    await seedProductCatalogProducts(data);
    await seedProductCatalogIndicators(data);
  }
}

export { seedProductCatalog };
