
tickNum = 0
potatoCount = 0
cmTime = 50
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
  setInterval ->
    potatoTick()
    copyMachine()
    achievementCheck()
  , 1000

  
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

potatoGet  = ->
  potatoCount += 1
  $( "#label").text("Potatoes: #{countConvert(potatoCount)}")

potatoTick = ->
  for type in buildings
      modifier += type.getMod()
  potatoCount += modifier*magicMultiplier


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
