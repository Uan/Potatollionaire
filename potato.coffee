potatoCount = 0
potatoUpgrades = {}

potatoInit = ->
  potatoCount += 1
  upgradeInsert
  console.log potatoCount
setInterval (potatoInit), 100
upgradeInsert = ->
	type = ""
	if potatoCount % 20 == 0
		type = "field"
	potatoUpgrades[type] = potatoUpgrades[type]+=1
	console.log potatoUpgrades[type]

