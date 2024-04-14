import 'flavor_model.dart';

const flavorKey = 'FLAVOR';
const launchJsonPath = './.vscode/launch.json';
const settingsJsonPath = './.vscode/settings.json';
const workspaceXmlPath = './.idea/workspace.xml';

const flavorsList = [
  Flavor(flavorEnum: FlavorsEnum.dev, name: 'dev', prefix: 'DEV', envPath: './config/dev.env'),
  Flavor(flavorEnum: FlavorsEnum.qa, name: 'qa', prefix: 'QA', envPath: './config/qa.env'),
  Flavor(flavorEnum: FlavorsEnum.stg, name: 'stg', prefix: 'STG', envPath: './config/stg.env'),
  Flavor(flavorEnum: FlavorsEnum.prod, name: 'prod', prefix: 'PROD', envPath: './config/prod.env'),
];
