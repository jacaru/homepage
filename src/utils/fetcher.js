import config from "../../next.config";

export function fetchWithBase(path, init) {
  let p = path;
  const b = config.basePath || "";
  if (p[0] === "/") p = b + p;

  return fetch(p, init);
}

export function fetcherWithBase(path, init) {
  return fetchWithBase(path, init).then((res) => res.json());
}

