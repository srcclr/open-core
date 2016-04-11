angular.module('SC.routes.root')
.controller('RootCtrl', function($scope) {
  'use strict';

  $scope.dropdowns = {}

  $scope.toggleDropdown = function (key) {
    if(typeof $scope.dropdowns[key] !== 'undefined') {
      $scope.dropdowns[key] = !$scope.dropdowns[key];
    } else {
      $scope.dropdowns[key] = true;
    }
  };


  $scope.projectLanguageChoices = [
    'Java', 'JavaScript', 'Ruby', 'PHP', 'C#', 'C++', 'Python', 'Swift', 'Objective C', 'Rust', 'Go', 'Scala', 'Groovy', 'Clojure', 'Lisp', 'Dart', 'Other'
  ];


  $scope.components = [ {
    'id' : 1,
    'name' : 'async this is a package with more than 70 chars in the name of the package',
    'description' : 'Higher-order functions and common patterns for asynchronous code',
    'creationDate' : '2014-11-13T19:42:12.000+0000',
    'updatedDate' : null,
    'author' : 'Caolan McMahon',
    'authorUrl' : null,
    'languageType' : 'JS',
    'coordinateType' : 'NPM',
    'coordinate1' : 'async',
    'coordinate2' : '',
    'bugTrackerUrl' : 'https://github.com/caolan/async/issues',
    'codeRepoType' : 'GIT',
    'codeRepoUrl' : 'https://github.com/caolan/async.git',
    'lastSynced' : null,
    'latestRelease' : null,
    'links' : {
      'self' : 'http://localhost:9000/api/catalog/components/1',
      'versions' : 'http://localhost:9000/api/catalog/components/1/versions'
    },
    'versions' : [ {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ab8ece0c40627e4e8f0e09c8fcf7c19ed0c4241c',
      'sha2' : 'eea67621e937372eb754efc3f63283bb9250d0d9fcfdaa5f24dc129096119864',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'fb965e70dbea44c8a4b8a948472dee7d27279d5e',
      'sha2' : '9aa9e7d65e772be9374ed6fc08cb680c0af721acc63233a95a7d98adb13e12d0',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.1'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'be761882a64d3dc81a669f9ee3d5c28497382691',
      'sha2' : '43e8f45c77decc4945b50158e387c108e72439613e7103dfe4b1d2bd87f461fe',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.2'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '629ca2357112d90cafc33872366b14f2695a1fbc',
      'sha2' : 'fe8421ec6c75acacf5c6def66bee787d55bc89b65b26bbbc85bf54855bcb626a',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.3'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '29de4b98712ab8858411d8d8e3361a986c3b2c18',
      'sha2' : '447f7d46b1c1a88770ff839d5048a63d771e46c6ca3b59874f8faedcf0e798a3',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.4'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '9d83e3d4adb9c962fc4a30e7dd04bf1206c28ea5',
      'sha2' : 'bc636c27987042b0daa5b8532d5935302a1c227a1b65ce18fecba777e3c4c753',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.5'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '2dfb4fa1915f86056060c2e2f35a7fb8549907cc',
      'sha2' : 'e03a08a230acd0d444d89aa67cc2cff51c0516243b0ec97d00ba7c1fa9f616ac',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.6'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'e9268d0d8cd8dcfe0db0895b27dcc4bcc5c739a5',
      'sha2' : '3204dcb8b2e977b4cc61bc9c504e7d43ba4fe869f8f4f8cf757b5e49fee01573',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.7'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '52f2df6c0aa6a7f8333e1fbac0fbd93670cf6758',
      'sha2' : 'b060085803eeaea498694886c56d87ac2dcaabfcf37b8fa2497d924d15619baf',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.8'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'f984d0739b5382c949cc3bea702d21d0dbd52040',
      'sha2' : 'e27dc118605c11558b3d1b1cb59d1f69274844bcdf12fcdde246bfa87de34943',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.9'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '12b32bf098fa7fc51ae3ac51441b8ba15f437cf1',
      'sha2' : '74ead05e96f5cd5b719b50847e201d39b45a94505f63935fbe45311d504d9a87',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.10'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'a397a69c6febae232d20a76a5b10d8742e2b8215',
      'sha2' : '34eee9f4242012098dfcfd82adb0e8d682d562ce03ea0391653b2750e8102169',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.11'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ab36be6611dc63d91657128e1d65102b959d4afe',
      'sha2' : '84f4a932fe674610b3f6c77c58b239ff29c369d580a4edaa8bf7c753e31d15cd',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.12'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'f1e53ad69dab282d8e75cbec5e2c5524b6195eab',
      'sha2' : '834b0b31840d4edaedac192a8c867cc99a1774a180255e857437627be1279d4d',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.13'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '0fcfaf089229fc657798203d1a4544102f7d26dc',
      'sha2' : 'b19c19a04fd2f42608d72d4a49392855e16cee20cac2c9be929e7e3e23305eef',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.14'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '2180eaca2cf2a6ca5280d41c0585bec9b3e49bd3',
      'sha2' : 'f6f0d97f34bee268bc44b5403e2f0ba147d5aa5da3c351d5d1b2838d7ea9e5cb',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.15'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'b3a61fdc1a9193d4f64755c7600126e254223186',
      'sha2' : 'a16da31a7528dda1122d09060d0da2395b21fe7d17bfba34df2b915bc546bc2b',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.16'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '03524a379e974dc9ee5c811c6ee3815d7bc54f6e',
      'sha2' : '8534fc0bcc471268ff1dd8477a0c47651511085638ef59e23c0b32da31d60906',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.17'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'c59c923920b76d5bf23248c04433920c4d45086a',
      'sha2' : '469ad887f6486004af3303c9c8e260bc104a9d1657eee77055c3d0605e200e33',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.18'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : '4fd6125a70f841fb10b14aeec6e23cf1479c71a7',
      'sha2' : '991d62fe51869c88cfcd3c5f43044c9396a5909444b29f92b78a3d0a07c3c19c',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.19'
    }, {
      'dateAdded' : '2014-11-13T19:42:12.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ba0e47b08ae972e04b5215de28539b313482ede5',
      'sha2' : '27ce7e6fcaaf6ea9dcd6c99112f1ca21c37998bc48df6faabb906186195ba367',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.20'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'b5b12e985f09ab72c202fa00f623cd9d997e9464',
      'sha2' : 'bb8de15acb810c63427f634639565f04391a1aa668109801ca471e9264b3fe66',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.21'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '0fc1aaa088a0e3ef0ebe2d8831bab0dcf8845061',
      'sha2' : '6fd2750cd519a754b0e32ef3423e64768055129e00a95d9297005bda29fdef18',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.1.22'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'db1c645337bab79d0ca93d95f5c72d9605be0fce',
      'sha2' : '3695de7fb735564997368c30b6c3de0204c40916b890c3a2641390b2d67b90ff',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '4e37d08391132f79657a99ca73aa4eb471a6f771',
      'sha2' : '1816161b3155b92896bda7728362062e85369e10afaec3f5a167858ad8df0998',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.1'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '8414ee47da7548126b4d3d923850d54e68a72b28',
      'sha2' : '74f5f0814709e843c11a6751aca0ff8cb9c69c4225f898ea3b6422db7a5608b7',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.2'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '79bf601d723a2e8c3e91cb6bb08f152dca309fb3',
      'sha2' : 'a41c2d6b4ff4bbb28829c8eea29e2f0184be5624e3aa11441354f3f868d48546',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.3'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '0550e510cf43b83e2fcf1cb96399f03f1efd50eb',
      'sha2' : '62820fd1d78e194368711fef2109adc5b14d75fdbf208fa199715d583ae807c8',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.4'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '45f05da480749ba4c1dcd8cd3a3747ae7b36fe52',
      'sha2' : '2b105d182c2e4cbdcda4ed016afa3c1fc98834b3de815fd695c9e4a3511bcd9a',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.5'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ad3f373d9249ae324881565582bc90e152abbd68',
      'sha2' : '0fbf8ceedeb94a1783e73e3cbfab0ddd926a66f31ef6d040bb9d2e7c831206d6',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.6'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '44c5ee151aece6c4bf5364cfc7c28fe4e58f18df',
      'sha2' : '6f0b4eaf5cf8b0e3bf172e49b43bd579ab84cf30b860b035812381117ce706a4',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.7'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ba1b3ffd1e6cdb1e999aca76ef6ecee8e7f55f53',
      'sha2' : '45d7c5ef1b87dc183b9265b882ae3fb2c20608832adc3234b766717016be2346',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.8'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'df63060fbf3d33286a76aaf6d55a2986d9ff8619',
      'sha2' : '7215c94b63ccaa543b4b75c5dd9b820fd4839e1f9616b08a0334a8ac74939c53',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.9'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'b6bbe0b0674b9d719708ca38de8c237cb526c3d1',
      'sha2' : '46869f9efcfc4045217c7730f65a81f85b518a0765d14f931ddb70581afb644c',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.2.10'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '6d2c543c25f514c602bb22916ac222a519290d5d',
      'sha2' : 'd9e5e21f7fc9aae0caf7f5ab3adb45e70166fd5b51f7ef44eff9c41c8e387373',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.3.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '208bba02850129dacc2bc3959e4126570ae80b74',
      'sha2' : '6020cc8ea51f7f34d75cd1b97ce97bfa6eb2c677628c9db7b1f39805c42921cb',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.4.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '1985abade017df906bfaa8d77d424b25366b3a5b',
      'sha2' : 'dc877a0e07a0037fef62b94a85f68e9a8ef4beb103409209a4e435ab4561469b',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.4.1'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '524bc1cf3ed2b6adc7f4a8c4987dd9c4809c764f',
      'sha2' : '18ffd939425d116e2febfe1384935e81dc4ce0490c60b795884d743958100ed5',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.5.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '025a31c8b1fb11e7481fa18dbdbc2bf2e434933a',
      'sha2' : 'da81fe99d1490b48ee1225f32df42eb564761e61ed07056631b7502882fac812',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.6.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '594fe360968fcdd2d7e0a6d95a874e4e92c7a26d',
      'sha2' : '7a9aa08c8d629faee80edf8e09b4b611051e545bd9c1169bac98489829b8f7f5',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.6.1'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '41fd038a3812c0a8bc1842ecf08ba63eb0392bef',
      'sha2' : 'a48308d7ec0d23763c3e9e35d4447d947a5f1cfeb8df2ccc1f1103557590f1e2',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.6.2'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : '4429e0e62f5de0a54f37458c49f0b897eb52ada5',
      'sha2' : 'e662714306c526a396b1995aabe65842df995717f5c0de6ee4ed44082b077405',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.7.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ee65ec77298c2ff1456bc4418a052d0f06435112',
      'sha2' : 'd9d39a62b80d54e48e4bb2e047de5fcccc37bfdc453110d7f7135db34540744c',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.8.0'
    }, {
      'dateAdded' : '2014-11-13T19:42:13.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'ac3613b1da9bed1b47510bb4651b8931e47146c7',
      'sha2' : 'fe953668526b50e8aced19d0c5ad5c224ea8c0ec3427a0f03f2aa0043f487575',
      'fingerprints' : [ 'async' ],
      'links' : { },
      'version' : '0.9.0'
    } ]
  }, {
    'id' : 2,
    'name' : 'a9n-changed',
    'description' : 'a9n is a tool to keep ruby/rails apps extra configuration easily maintainable and verifiable',
    'creationDate' : '2014-11-13T19:45:22.000+0000',
    'updatedDate' : '2014-11-14T21:37:10.000+0000',
    'author' : 'Krzysztof Knapik',
    'authorUrl' : 'https://github.com/knapo/a9n',
    'languageType' : 'RUBY',
    'coordinateType' : 'GEM',
    'coordinate1' : 'a9n',
    'coordinate2' : '',
    'bugTrackerUrl' : 'https://github.com/knapo/a9n/issues',
    'codeRepoType' : null,
    'codeRepoUrl' : 'https://github.com/knapo/a9n',
    'lastSynced' : null,
    'latestRelease' : null,
    'links' : {
      'self' : 'http://localhost:9000/api/catalog/components/2',
      'versions' : 'http://localhost:9000/api/catalog/components/2/versions'
    },
    'versions' : [ {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : '813833013162341dece24f38863ff1b5e65b547f',
      'sha2' : '3032f269bc5c33b1bbb879fbf21719e7d5f0458774403fc7a437594e0b898481',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.3.1'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'facbb7c58010679168442a4e73f52da0858467b1',
      'sha2' : '549a7be83617784095ffcf52482697885764782abb7d65ff13f84a62f66abac0',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.3.0'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'b96ae2dcc6034094d8391cbe8dc87cff78439746',
      'sha2' : '346ba3ab8311575fd65920f3bf795f33c6cad1c8e7d00657b76fce535c9f4d1d',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.2.3'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'dc6dc5a9616b2ebc06e542bda4c20e291ee396ab',
      'sha2' : '30bfc9b840499a41d8e6a8c228ced356c21524bfcc23a229dbad6d7c0a627f7b',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.2.2'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'bfd435c56a59b0e33d355c6158bafbca808ca93e',
      'sha2' : 'be0acdbb8745e17ec83da90b90d35d38cffb155b3046718b77834a6742b964ce',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.2.0'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : '5e8f6a6ef6f668748f4a52d3017ee895d2cdd64a',
      'sha2' : '30d3c713e38393f5fd0e8c6dea89178298e9c5ec419231b0b30d2d5425580080',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.1.3'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'b50f394a993d2610e81dd7edc46ee567c40b0b39',
      'sha2' : 'dff270defb9fa8429c8c5aa2a3f6382af46bb3361b6600b4af91a9bef7cace42',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.1.2'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : '70e64cb660a20b8005b656518d880a6da18421dc',
      'sha2' : 'eb5b571fad7dd32cb6e3f5d90f63765aa67e9cf8bd9080309f7c4dd932ef94ad',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.1.1'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'a6207398d97ac2f9c493c771a1ffc64836f5577b',
      'sha2' : '41a1b54e3e85211cfc4a66766ba2958b64387d17b243e6252dadd0edb9d8ba15',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.1.0'
    }, {
      'dateAdded' : '2014-11-13T19:45:22.000+0000',
      'bytecodeHash' : null,
      'sha1' : '0dbfa7a84c0e02451c111abbf12f0a2cd2343d0a',
      'sha2' : '6f3d1f2ff6089484810e131946544b022c3ca1b29ef3ebca1d82167a6060c04a',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.9'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'fdc44b4c0ac41cbfcc3ef4e849f73152c6a4394e',
      'sha2' : '2f6e9f35875dba7823194957d1b5fc0d536619da12c2529e163fc8864487e914',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.8'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'f50722792408ebfbf25bbfc9d5a2764a9a91c695',
      'sha2' : 'a501d43c74e548bebfc21bbd070511b4307faed53171ad50a88073da9e179517',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.7'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'd2b34cb08da7f31df22fa4936bdf62fb1e090103',
      'sha2' : '6535c8a780001f7ab77cc7b5059bc96b61bd5b3398b7dfc365ca13d7face5031',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.6'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : 'e0a1c49e12e72cdfb3a359d9b9befb9df7dd22e0',
      'sha2' : '9b8fec6b1f22a942939350ad6b2063bbcbb6d7c6518e6aee52f5d5c2c29d148c',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.5'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : '8777cc71fb2f83fba0f05b678e7ebba4a118824e',
      'sha2' : 'd7107ad9052af75747e0c006e4e79b9fab67b3ce490ed71de511d6e5bf57bf0d',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.4'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : '9f210c82c2de0abebbaa0f4773b8991363916b71',
      'sha2' : 'bc9ba135ee6adffdb1f30122133ca3545cf26c67ff22e54306fc1e66ae861060',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.3'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : '629cb6fcfbc4119bb8c1b63db777d3d73351c0a7',
      'sha2' : '4531ee6d7dba1aaecd22dff1ab6af6e1744a687bbf24b2fcb6bafe085be281e4',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.2'
    }, {
      'dateAdded' : '2014-11-13T19:45:23.000+0000',
      'bytecodeHash' : null,
      'sha1' : '953e2cb10eb6ce84258ab7c3b155566e4c0a8220',
      'sha2' : '323b37f6aa44747190abd517da92acf499c9818f3c69ab0bb1cb3ad2d5d09a2c',
      'fingerprints' : [ 'a9n' ],
      'links' : { },
      'version' : '0.0.1'
    } ]
  }];

});