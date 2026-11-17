// Exporta una aplicación APEX del contenedor local como export dividido (un archivo por componente,
// igual que db/oracle/apex/f106) en db/oracle/apex/f<APP>/, en UTF-8.
// Uso (desde la raíz del repo, Node 20):  node db/oracle/apex/build/export_split.js 160
// La carpeta destino se vacía antes de escribir, para que los componentes eliminados en APEX
// desaparezcan también del repositorio.
const fs = require('fs');
const path = require('path');
const oracledb = require('oracledb');
oracledb.fetchAsString = [oracledb.CLOB];

const app = Number(process.argv[2] || 160);
const out = path.resolve(__dirname, '..', `f${app}`);

(async () => {
  const conn = await oracledb.getConnection({ user: 'siif', password: 'siif', connectString: 'localhost:1521/FREEPDB1' });
  try {
    // Sin fecha en el encabezado, para que dos exportaciones seguidas den los mismos archivos (diffs
    // limpios en git). La exportación hace commit interno: se llama desde PL/SQL, no desde un SELECT.
    const res = await conn.execute(
      `declare
         l_files apex_t_export_files;
       begin
         apex_util.set_workspace(p_workspace => 'SPD');
         l_files := apex_export.get_application(p_application_id => :app, p_split => true, p_with_date => false,
                      p_with_ir_public_reports => true, p_with_comments => true);
         open :rc for select name, contents from table(l_files);
       end;`,
      { app, rc: { dir: oracledb.BIND_OUT, type: oracledb.CURSOR } });
    const rs = res.outBinds.rc;
    const r = { rows: [] };
    let batch;
    while ((batch = await rs.getRows(500)).length) r.rows.push(...batch);
    await rs.close();
    r.rows = r.rows.map(([NAME, CONTENTS]) => ({ NAME, CONTENTS }));
    if (!r.rows.length) throw new Error(`La aplicación ${app} no existe en el workspace SPD`);

    if (fs.existsSync(out)) {
      for (const f of fs.readdirSync(out)) fs.rmSync(path.join(out, f), { recursive: true, force: true });
    }
    // los nombres vienen como "f160/application/pages/page_01011.sql"
    let n = 0;
    for (const { NAME, CONTENTS } of r.rows) {
      const rel = NAME.replace(new RegExp(`^f${app}/`), '');
      const file = path.join(out, rel);
      fs.mkdirSync(path.dirname(file), { recursive: true });
      fs.writeFileSync(file, CONTENTS.replace(/\r\n/g, '\n'), 'utf8');
      n++;
    }
    console.log(`f${app}: ${n} archivos en ${path.relative(process.cwd(), out)}`);
  } finally {
    await conn.close();
  }
})().catch(e => { console.error(e.message); process.exit(1); });
