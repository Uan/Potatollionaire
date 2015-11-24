
tickNum = 0
potatoCount = 0
cmTime = 50
modifier = 0
magicMultiplier = 1
mana = 0
spells = {}
activeSpells = {}
clickValue = 1
totalClicks = 0

initStuff = ->
  initUpgrades()
  initMagic()
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
  potatoCount += clickValue
  totalClicks += 1
  $( "#label").text("Potatoes: #{numberShortener(potatoCount)}")
  # console.log(buildings)

potatoTick = ->
  modifier = 0
  for building in buildings
      modifier += building.getMod()*building.getNum()
  potatoCount += modifier*magicMultiplier


round = (number,n) ->
  n ?=3 
  return  Math.round number if n==1 
  Math.round(number*(10**(n)))/(10**(n))
    
numberShortener = (number) ->
  return round(number) if number<1000
  arr = ['K','M','B','T','Qa','Qi']
  multiplier = 1
  until (10**(3*(multiplier+1)))>number
    multiplier+=1 
  "#{round(number/(10**(multiplier*3)))}#{arr[multiplier-1]}"