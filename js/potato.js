// Generated by CoffeeScript 1.10.0
(function() {
  $(function() {
    var buttonValues, countConvert, initStuff, modifier, potatoCount, potatoGet, potatoTick, potatoUpgrades, showDict, uiUpdate, upgradeCooficients, upgradeCosts, upgradeCostsN, upgradeInsert, upgradeNumbers, upgradeTypes;
    potatoCount = 0;
    potatoUpgrades = {};
    upgradeCooficients = {};
    upgradeCosts = {};
    upgradeTypes = ["farm", "factory", "kappa"];
    upgradeNumbers = [2, 5, 10];
    upgradeCostsN = [10, 100, 200];
    modifier = 0;
    initStuff = function() {
      var i, index, results;
      results = [];
      for (index = i = 0; i < 3; index = ++i) {
        potatoUpgrades[upgradeTypes[index]] = 0;
        upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index];
        results.push(upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]);
      }
      return results;
    };
    initStuff();
    showDict = function() {
      console.log(upgradeCooficients);
      return console.log(potatoUpgrades);
    };
    potatoGet = function() {
      potatoCount += 1;
      showDict();
      return $("#label").text("Potatoes: " + potatoCount);
    };
    potatoTick = function() {
      var i, len, type;
      modifier = 0;
      for (i = 0, len = upgradeTypes.length; i < len; i++) {
        type = upgradeTypes[i];
        modifier += potatoUpgrades[type] * upgradeCooficients[type];
      }
      return potatoCount += modifier;
    };
    uiUpdate = function() {
      $("#label").text("Potatoes: " + (countConvert(potatoCount)));
      return $("#ps").text("Potatoes/second: " + modifier);
    };
    setInterval(potatoTick, 1000);
    setInterval(uiUpdate, 100);
    upgradeInsert = function(type) {
      var resCount;
      if (!(potatoCount < upgradeCosts[type])) {
        potatoUpgrades[type] = potatoUpgrades[type] += 1;
        potatoCount -= upgradeCosts[type];
        upgradeCosts[type] *= 2;
        upgradeCooficients[type] *= 1.5;
        resCount = potatoUpgrades[type];
        $("#" + type + "Count").text(type + ": " + resCount);
        return buttonValues();
      }
    };
    countConvert = function(number) {
      if (number >= 1000000000) {
        return number / 1000000000 + "B";
      } else if (number >= 1000000) {
        return number / 1000000 + "M";
      } else if (number >= 1000) {
        return number / 1000 + "K";
      } else {
        return number;
      }
    };
    buttonValues = function() {
      $("#upgradeBtnF").attr("value", "Build a Farm. Cost: " + upgradeCosts["farm"]);
      $("#upgradeBtnFa").attr("value", "Build a Factory. Cost: " + upgradeCosts["factory"]);
      return $("#upgradeBtnK").attr("value", "Build a Kappa. Cost: " + upgradeCosts["kappa"]);
    };
    $("#upgradeBtnFa").on("click", function() {
      return upgradeInsert("factory");
    });
    $("#upgradeBtnK").on("click", function() {
      return upgradeInsert("kappa");
    });
    $("#upgradeBtnF").on("click", function() {
      return upgradeInsert("farm");
    });
    $("#upgradeBtnFa").on("click", function() {
      return upgradeInsert("factory");
    });
    $("#upgradeBtnK").on("click", function() {
      return upgradeInsert("kappa");
    });
    $("#potatoGet").on("click", function() {
      return potatoGet();
    });
    return $(":button").on("click", function() {
      return uiUpdate();
    });
  });

}).call(this);
