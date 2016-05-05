mkdir %1
cd %1

echo Creating package.json file

(
 echo {
 echo "name": "%2",
 echo "version": "1.0.0",
 echo "scripts": {
 echo   "start": "tsc && concurrently \"npm run tsc:w\" \"npm run lite\" ",
 echo   "tsc": "tsc",
 echo   "tsc:w": "tsc -w",
 echo   "lite": "lite-server",
 echo   "typings": "typings",
 echo   "postinstall": "typings install"
 echo },
 echo "license": "MIT",
 echo "dependencies": {
 echo   "angular2": "2.0.0-beta.14",
 echo   "systemjs": "0.19.25",
 echo   "es6-shim": "^0.35.0",
 echo   "reflect-metadata": "0.1.2",
 echo   "rxjs": "5.0.0-beta.2",
 echo   "zone.js": "0.6.6"
 echo },
 echo "devDependencies": {
 echo   "concurrently": "^2.0.0",
 echo   "lite-server": "^2.2.0",
 echo   "typescript": "^1.8.9",
 echo   "typings":"^0.7.12"
 echo }
 echo }

) > "package.json"

echo creating tsconfig.json

(
 echo {
  echo "compilerOptions": {
    echo "target": "es5",
    echo "module": "system",
    echo "moduleResolution": "node",
    echo "sourceMap": true,
    echo "emitDecoratorMetadata": true,
    echo "experimentalDecorators": true,
    echo "removeComments": false,
    echo "noImplicitAny": false
  echo },
  echo "exclude": [
    echo "node_modules",
    echo "typings/main",
    echo "typings/main.d.ts"
  echo ]
echo }

) > "tsconfig.json"


echo creating typings.json
(
echo {
  echo "ambientDependencies": {
  echo   "es6-shim": "github:DefinitelyTyped/DefinitelyTyped/es6-shim/es6-shim.d.ts#7de6c3dd94feaeb21f20054b9f30d5dabc5efabd",
  echo   "jasmine": "github:DefinitelyTyped/DefinitelyTyped/jasmine/jasmine.d.ts#7de6c3dd94feaeb21f20054b9f30d5dabc5efabd"
 echo  }
echo }

) > "typings.json"

echo creating index.html

(
echo ^<html^>
  echo ^<head^>
    echo ^<title^>Hero App^</title^>
    echo ^<meta name="viewport" content="width=device-width, initial-scale=1"^>
    echo ^<link rel="stylesheet" href="styles.css"^>
    echo ^<base href="/" ^>
  echo   ^<^^!-- 1. Load libraries --^>
    echo ^<^^!-- IE required polyfills, in this exact order --^>
    echo ^<script src="node_modules/es6-shim/es6-shim.min.js"^>^</script^>
    echo ^<script src="node_modules/systemjs/dist/system-polyfills.js"^>^</script^>
    echo ^<script src="node_modules/angular2/es6/dev/src/testing/shims_for_IE.js"^>^</script^>
    echo ^<script src="node_modules/angular2/bundles/angular2-polyfills.js"^>^</script^>
    echo ^<script src="node_modules/systemjs/dist/system.src.js"^>^</script^>
    echo ^<script src="node_modules/rxjs/bundles/Rx.js"^>^</script^>
    echo ^<script src="node_modules/angular2/bundles/angular2.dev.js"^>^</script^>
    echo ^<script src="node_modules/angular2/bundles/router.dev.js"^>^</script^>
    echo ^<^^!-- 2. Configure SystemJS --^>
    echo ^<script^>
      echo System.config^({
        echo packages: {
          echo app: {
            echo format: ^'register^',
            echo defaultExtension: ^'js^'
          echo }
        echo }
      echo }^);
      echo System.import^(^'app/main^'^)
      echo       .then^(null, console.error.bind^(console^)^);
    echo ^</script^>
  echo ^</head^>
  echo ^<^^!-- 3. Display the application --^>
  echo ^<body^>
  echo   ^<hero-app^>Loading...^</hero-app^>
  echo ^</body^>
echo ^</html^>
) > "index.html"

echo creating .gitignore
(
echo /node_modules
echo /typings
echo /app/*.js
echo /app/*.js.map
echo npm-debug.log
) > ".gitignore"

echo making app directory

mkdir app
cd app

echo making main.ts for bootstrapping

(
echo import {bootstrap} from ^'angular2/platform/browser^';
echo import {AppComponent} from ^'./app.component^';
echo     bootstrap^(AppComponent^);
) > "main.ts"

echo generating app.component.ts for main application file

(
echo import {Component} from ^'angular2/core^';
echo @Component^({
echo     selector: ^'hero-app^',
echo     template: ^'^'
echo }^)
echo export class AppComponent {
echo     title = ^'Tour of Heros^';
echo }
) > "app.component.ts"

npm install
