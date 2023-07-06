const watch = process.argv.slice(2).includes('--watch');

require('esbuild')
  .context({
    entryPoints: [
      { in: 'app/javascript/application.js', out: 'application' },
      // { in: 'engines/[engine_name]/app/javascript/[engine_name]/application.js', out: '[engine_name]/application' },
    ],
    inject: ['app/javascript/global.js'],
    bundle: true,
    sourcemap: true,
    minify: !watch,
    outdir: 'app/assets/builds',
  })
  .then((ctx) => {
    watch ? ctx.watch() : ctx.rebuild().then(() => process.exit(0));
  })
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
