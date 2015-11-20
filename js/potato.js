// Generated by CoffeeScript 1.10.0
(function() {
  var Spell, SummonGolem, activeSpells, copyMachine, countConvert, initStuff, magicMultiplier, mana, modifier, potatoCount, potatoGet, potatoTick, potatoUpgrades, roundToTwo, sacrifice, showDict, spells, tickNum, uiUpdate, upgradeCooficients, upgradeCosts, upgradeCostsN, upgradeInsert, upgradeNumbers, upgradeTypes,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  Spell = (function() {
    function Spell(name) {
      this.name = name;
      this.cast = bind(this.cast, this);
      this.tick = bind(this.tick, this);
      this.expiration = bind(this.expiration, this);
      this.effect = bind(this.effect, this);
      this.description;
      this.cost;
      this.duration;
      ({
        duration_cur: 0
      });
    }

    Spell.prototype.effect = function() {
      return this.tick();
    };

    Spell.prototype.expiration = function() {
      return this.duration_cur = 0;
    };

    Spell.prototype.tick = function() {
      if (this.duration_cur > 0) {
        this.duration_cur -= 1;
        return setTimeout(this.tick, 1000);
      } else {
        return this.expiration();
      }
    };

    Spell.prototype.cast = function() {
      if (!(mana < this.cost)) {
        this.duration_cur = this.duration;
        mana -= this.cost;
        return this.effect();
      }
    };

    return Spell;

  })();

  SummonGolem = (function(superClass) {
    extend(SummonGolem, superClass);

    function SummonGolem() {
      this.expiration = bind(this.expiration, this);
      this.effect = bind(this.effect, this);
      SummonGolem.__super__.constructor.call(this, "golem");
    }

    SummonGolem.prototype.description = "summon potato golem to boost your production";

    SummonGolem.prototype.cost = 10;

    SummonGolem.prototype.duration = 60;

    SummonGolem.prototype.effect = function() {
      SummonGolem.__super__.effect.apply(this, arguments);
      return magicMultiplier += 0.15;
    };

    SummonGolem.prototype.expiration = function() {
      return magicMultiplier -= 0.15;
    };

    return SummonGolem;

  })(Spell);

  sacrifice = function(n) {
    if (!(potatoCount < n)) {
      mana += n;
      return potatoCount -= n;
    }
  };

  tickNum = 0;

  potatoCount = 0;

  potatoUpgrades = {};

  upgradeCooficients = {};

  upgradeCosts = {};

  upgradeTypes = ["farm", "factory", "kappa", "copy_machine"];

  upgradeNumbers = [2, 5, 10, 0];

  upgradeCostsN = [10, 100, 200, 10];

  modifier = 0;

  magicMultiplier = 1;

  mana = 0;

  spells = {};

  activeSpells = {};

  initStuff = function() {
    var index, j;
    for (index = j = 0; j <= 4; index = ++j) {
      potatoUpgrades[upgradeTypes[index]] = 0;
      upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index];
      upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index];
    }
    spells["golem"] = new SummonGolem;
    setInterval(potatoTick, 1000);
    setInterval(copyMachine, 1000);
    return setInterval(uiUpdate, 200);
  };

  copyMachine = function() {
    var i, j, prob, ref, results;
    if (tickNum === 5) {
      results = [];
      for (i = j = 0, ref = potatoUpgrades["copy_machine"]; 0 <= ref ? j < ref : j > ref; i = 0 <= ref ? ++j : --j) {
        prob = Math.floor(Math.random() * 100);
        if (prob <= 80) {
          upgradeInsert("farm", "cm");
        } else if (prob <= 95) {
          upgradeInsert("factory", "cm");
        } else {
          upgradeInsert("kappa", "cm");
        }
        results.push(tickNum = 0);
      }
      return results;
    } else {
      return tickNum += 1;
    }
  };

  showDict = function() {
    console.log(upgradeCooficients);
    return console.log(potatoUpgrades);
  };

  potatoGet = function() {
    potatoCount += 1;
    return $("#label").text("Potatoes: " + (countConvert(potatoCount)));
  };

  potatoTick = function() {
    var j, len, type;
    modifier = 0;
    for (j = 0, len = upgradeTypes.length; j < len; j++) {
      type = upgradeTypes[j];
      modifier += potatoUpgrades[type] * upgradeCooficients[type];
    }
    return potatoCount += modifier * magicMultiplier;
  };

  uiUpdate = function() {
    $("#label").text("Potatoes: " + (countConvert(potatoCount)));
    $("#ps").text("Potatoes/second: " + (countConvert(modifier)));
    $("#mana").text("mana: " + mana);
    $("#spellmod").text("" + magicMultiplier);
    return displayUpgrade();
  };

  upgradeInsert = function(type, source) {
    if (potatoCount >= upgradeCosts[type] && source === "user") {
      console.log("user has made a " + type);
      potatoUpgrades[type] = potatoUpgrades[type] += 1;
      potatoCount -= upgradeCosts[type];
      upgradeCosts[type] *= 2;
      upgradeCooficients[type] *= 1.15;
    } else if (source === "cm") {
      potatoUpgrades[type] = potatoUpgrades[type] += 1;
      upgradeCooficients[type] *= 1.15;
    }
    return buttonValues();
  };

  roundToTwo = function(number) {
    return Math.round(number * 10) / 10;
  };

  countConvert = function(number) {
    if (number >= 1000000000) {
      return roundToTwo(number / 1000000000) + "B";
    } else if (number >= 1000000) {
      return roundToTwo(number / 1000000) + "M";
    } else if (number >= 1000) {
      return roundToTwo(number / 1000) + "K";
    } else {
      return roundToTwo(number);
    }
  };

  $(function() {
    var buttonValues, displayUpgrade;
    displayUpgrade = function() {
      var i, j, ref, results, type;
      $("#resourceDisplay").text("");
      results = [];
      for (i = j = 0, ref = upgradeTypes.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
        type = upgradeTypes[i];
        if (potatoUpgrades[type] > 0) {
          results.push($("#resourceDisplay").append("<p>" + type + ": " + potatoUpgrades[type] + "</p>"));
        } else {
          results.push(void 0);
        }
      }
      return results;
    };
    buttonValues = function() {};
    $("#upgradeBtnF").attr("value", "Build a Farm. Cost: " + (countConvert(upgradeCosts["farm"])));
    $("#upgradeBtnFa").attr("value", "Build a Factory. Cost: " + (countConvert(upgradeCosts["factory"])));
    $("#upgradeBtnK").attr("value", "Build a Kappa. Cost: " + (countConvert(upgradeCosts["kappa"])));
    $("#upgradeBtnC").attr("value", "Build a Copy machine. Cost: " + (countConvert(upgradeCosts["copy_machine"])));
    $("#upgradeBtnFa").on("click", function() {
      return upgradeInsert("factory", "user");
    });
    $("#upgradeBtnK").on("click", function() {
      return upgradeInsert("kappa", "user");
    });
    $("#upgradeBtnF").on("click", function() {
      return upgradeInsert("farm", "user");
    });
    $("#upgradeBtnC").on("click", function() {
      return upgradeInsert("copy_machine", "user");
    });
    $("#potatoGet").on("click", function() {
      return potatoGet();
    });
    $(":button").on("click", function() {
      return uiUpdate();
    });
    $("#sacrifice1").on("click", function() {
      return sacrifice(1);
    });
    $("#spell1").on("click", function() {
      return spells["golem"].cast();
    });
    uiUpdate = function() {
      $("#label").text("Potatoes: " + (countConvert(potatoCount)));
      $("#ps").text("Potatoes/second: " + (countConvert(modifier)));
      $("#mana").text("mana: " + mana);
      $("#spellmod").text("" + magicMultiplier);
      return displayUpgrade();
    };
    return initStuff();
  });

}).call(this);
