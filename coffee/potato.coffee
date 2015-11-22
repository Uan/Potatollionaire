
tickNum = 0
potatoCount = 0
cmTime = 50
modifier = 0
magicMultiplier = 1
mana = 0
spells = {}
activeSpells = {}

initStuff = ->
  spells["golem"] = new SummonGolem
  setInterval ->
    potatoTick()
    #copyMachine()
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
  console.log(buildings)

potatoTick = ->
  modifier = 0
  for building in buildings
      modifier += building.getMod()*building.getNum()
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
