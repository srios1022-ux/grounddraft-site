// Serves the static site. Folder paths ("/", "/x/") get their index.html; every other file is served as-is,
// so links ending in .html keep working without redirects. www.grounddraft.app redirects to grounddraft.app.
export default {
  async fetch(req, env) {
    const url = new URL(req.url);
    if (url.hostname === 'www.grounddraft.app') {
      url.hostname = 'grounddraft.app';
      return Response.redirect(url.toString(), 301);
    }
    if (url.pathname.endsWith('/')) {
      url.pathname += 'index.html';
      return env.ASSETS.fetch(new Request(url, req));
    }
    return env.ASSETS.fetch(req);
  },
};
