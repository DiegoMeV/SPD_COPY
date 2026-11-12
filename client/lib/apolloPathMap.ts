const apolloPathMap: Record<string, string> = {
  createUserAccount: "Creando Usuario",
  updateUserAccount: "Actualizando Usuario",
  userLogin: "Iniciando Sesión",
  deleteMonitoringConfig: "Eliminando Parámetros de Seguimiento",
};

const getTitleForErrorPath = (path: string) => {
  return apolloPathMap[path] ?? path;
};

export { getTitleForErrorPath };
