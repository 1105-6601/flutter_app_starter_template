const bool isProduction = bool.fromEnvironment('dart.vm.product');

const VariablesDev = {
  'apiBaseUri': 'http://api.local.example.com:8888',
};

const VariablesProd = {
  'apiBaseUri': 'https://api.production.example.com',
};

final environment = isProduction ? VariablesProd : VariablesDev;
