
tickNum = 0
potatoCount = 0
cmTime = 50
potatoUpgrades = {}
upgradeCooficients = {}
upgradeCosts = {}
upgradeTypes = ["farm","factory","kappa","copy_machine"]
upgradeNumbers = [2,5,10,0]
upgradeCostsN = [10,100,200,10]
modifier = 0
magicMultiplier = 1
mana = 0
spells = {}
activeSpells = {}

initStuff = ->
  for index in [0..4]
    potatoUpgrades[upgradeTypes[index]] = 0
    upgradeCooficients[upgradeTypes[index]] = upgradeNumbers[index]
    upgradeCosts[upgradeTypes[index]] = upgradeCostsN[index]  
  spells["golem"] = new SummonGolem
  setInterval (potatoTick), 1000
  setInterval (copyMachine), 1000

  
copyMachine = ->
  if potatoUpgrades["copy_machine"] > 0
    if tickNum >= cmTime
      prob = Math.floor(Math.random() * 100)
      tickNum = 0
      if prob <= 80
        upgradeInsert("farm","cm")        
      else if prob <= 95
        upgradeInsert("factory","cm")       
      else
        upgradeInsert("kappa","cm")
    else
      tickNum+=1

showDict = ->
  console.log upgradeCooficients
  console.log potatoUpgrades

potatoGet  = ->
  potatoCount += 1
  $( "#label").text("Potatoes: #{countConvert(potatoCount)}")


potatoTick = ->
  modifier = 0
  for type in upgradeTypes
      modifier += potatoUpgrades[type]*upgradeCooficients[type]
  potatoCount += modifier*magicMultiplier

upgradeInsert = (type,source) ->
  if potatoCount >= upgradeCosts[type] and source == "user"
    console.log("user has made a #{type}")
    potatoUpgrades[type] = potatoUpgrades[type]+=1
    potatoCount -= upgradeCosts[type]
    upgradeCosts[type] *= 2
    upgradeCooficients[type] *= 1.15
    if type == "copy_machine"
      cmTime-=cmTime*.15
      console.log(cmTime)
  
  else if source == "cm" 
    potatoUpgrades[type] = potatoUpgrades[type]+=1
    upgradeCooficients[type] *= 1.15



roundToTwo = (number) ->
  return Math.round(number*10)/10
    
countConvert = (number) ->
  if number >= 1000000000
    return roundToTwo(number/1000000000) + "B"
  else if number >= 1000000
    return roundToTwo(number/1000000) + "M"
  else if number >= 1000
    return roundToTwo(number/1000) + "K"
  else return roundToTwo(number)
