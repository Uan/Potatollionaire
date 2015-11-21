// Generated by CoffeeScript 1.10.0
(function() {
  var Achievement, Spell, SummonGolem, achievementCheck, achievements, activeSpells, cmTime, copyMachine, countConvert, initStuff, magicMultiplier, mana, modifier, potatoCount, potatoGet, potatoTick, potatoUpgrades, roundToTwo, sacrifice, showDict, spells, tickNum, upgradeCooficients, upgradeCosts, upgradeCostsN, upgradeInsert, upgradeNumbers, upgradeTypes,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  achievements = [];

  Achievement = (function() {
    function Achievement(name, requirements, description, flavour_text) {
      this.name = name;
      this.requirements = requirements;
      this.description = description;
      this.flavour_text = flavour_text;
      this.tryUnlock = bind(this.tryUnlock, this);
      this.unlocked = false;
    }

    Achievement.prototype.tryUnlock = function() {
      if (this.requirements() && !this.unlocked) {
        console.log("achievement unlocked " + this.name);
        return this.unlocked = true;
      }
    };

    return Achievement;

  })();

  achievements[0] = new Achievement("test achievement", function() {
    return potatoCount > 0;
  }, "yeah whatever", "dank reference goes here");

  achievementCheck = function() {
    var i, j, len, results;
    results = [];
    for (j = 0, len = achievements.length; j < len; j++) {
      i = achievements[j];
      if (!i.unlocked) {
        results.push(i.tryUnlock);
      } else {
        results.push(void 0);
      }
    }
    return results;
  };

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

  cmTime = 50;

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
    return setInterval(function() {
      potatoTick();
      copyMachine();
      return achievementCheck();
    }, 1000);
  };

  copyMachine = function() {
    var prob;
    if (potatoUpgrades["copy_machine"] > 0) {
      if (tickNum >= cmTime) {
        prob = Math.floor(Math.random() * 100);
        tickNum = 0;
        if (prob <= 80) {
          return upgradeInsert("farm", "cm");
        } else if (prob <= 95) {
          return upgradeInsert("factory", "cm");
        } else {
          return upgradeInsert("kappa", "cm");
        }
      } else {
        return tickNum += 1;
      }
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

  upgradeInsert = function(type, source) {
    if (potatoCount >= upgradeCosts[type] && source === "user") {
      console.log("user has made a " + type);
      potatoUpgrades[type] = potatoUpgrades[type] += 1;
      potatoCount -= upgradeCosts[type];
      upgradeCosts[type] *= 2;
      upgradeCooficients[type] *= 1.15;
      if (type === "copy_machine") {
        cmTime -= cmTime * .15;
        return console.log(cmTime);
      }
    } else if (source === "cm") {
      potatoUpgrades[type] = potatoUpgrades[type] += 1;
      return upgradeCooficients[type] *= 1.15;
    }
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
    var buttonValues, displayBuildings, initUi, uiUpdate;
    initUi = function() {
      return setInterval(uiUpdate, 200);
    };
    displayBuildings = function() {
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
    buttonValues = function() {
      $("#upgradeBtnF").attr("value", "Build a Farm. Cost: " + (countConvert(upgradeCosts["farm"])));
      $("#upgradeBtnFa").attr("value", "Build a Factory. Cost: " + (countConvert(upgradeCosts["factory"])));
      $("#upgradeBtnK").attr("value", "Build a Kappa. Cost: " + (countConvert(upgradeCosts["kappa"])));
      return $("#upgradeBtnC").attr("value", "Build a Copy machine. Cost: " + (countConvert(upgradeCosts["copy_machine"])));
    };
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
      $("#spellmod").text("" + (countConvert(magicMultiplier)));
      displayBuildings();
      return buttonValues();
    };
    initStuff();
    return initUi();
  });

}).call(this);
