const watch = process.argv.slice(2).includes('--watch');

require('esbuild')
  .context({
    entryPoints: ['app/javascript/application.js'],
    inject: ['app/javascript/global.js'],
    bundle: true,
    sourcemap: true,
    outdir: 'app/assets/builds',
  })
  .then((ctx) => {
    watch ? ctx.watch() : ctx.rebuild().then(() => process.exit(0));
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
