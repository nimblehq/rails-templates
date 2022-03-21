const watch = process.argv.slice(2).includes('--watch');

require('esbuild').build({
  entryPoints: ['app/javascript/application.js'],
  inject: ['app/javascript/global.js'],
  bundle: true,
  sourcemap: true,
  watch: watch,
  outdir: 'app/assets/builds',
}).catch((error) => {
  console.error(error);
  process.exit(1);
});
