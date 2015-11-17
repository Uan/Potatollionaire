// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    var i, len, potatoCount, potatoGet, potatoTick, potatoUpgrades, type, upgradeInsert, upgradeTypes;
    potatoCount = 0;
    potatoUpgrades = {};
    upgradeTypes = ["farm", "factory", "kappa"];
    for (i = 0, len = upgradeTypes.length; i < len; i++) {
      type = upgradeTypes[i];
      potatoUpgrades[type] = 0;
    }
    potatoGet = function() {
      potatoCount += 1;
      return console.log(potatoCount);
    };
    potatoTick = function() {
      var j, len1, modifier;
      modifier = 0;
      for (j = 0, len1 = upgradeTypes.length; j < len1; j++) {
        type = upgradeTypes[j];
        if (type === "farm") {
          modifier += potatoUpgrades[type] * 2;
        }
        if (type === "factory") {
          modifier += potatoUpgrades[type] * 5;
        }
        if (type === "kappa") {
          modifier += potatoUpgrades[type] * 10;
        }
      }
      potatoCount += modifier;
      return console.log(potatoCount);
    };
    setInterval(potatoTick, 2000);
    upgradeInsert = function(type) {
      potatoUpgrades[type] = potatoUpgrades[type] += 1;
      return console.log(potatoUpgrades[type]);
    };
    $("#upgradeBtnF").on("click", function() {
      return upgradeInsert("farm");
    });
    $("#upgradeBtnFa").on("click", function() {
      return upgradeInsert("factory");
    });
    $("#upgradeBtnK").on("click", function() {
      return upgradeInsert("kappa");
    });
    return $("#potatoGet").on("click", function() {
      return potatoGet();
    });
  });

}).call(this);
