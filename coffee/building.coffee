buildings = []

class Building
	constructor: (@name, @cost, @modifier, @buttonID, @bDesc) ->
		@built = false
		@amount = 0
	purchase: ->	
		console.log("ey")
		if potatoCount >= @getCost()
			@built = true
			@amount+=1
			potatoCount-=@getCost()
			@increaseCost()
		else console.log("Not enough resources?")
	getMod: ->
		return @modifier
	isBuilt: ->
		return @built
	getName: ->
		return @name
	getCost: ->
		console.log(@cost)
		return @cost
	getNum: ->
		return @amount
	getButtonId: ->
		console.log @buttonID
		return @buttonID
	getDesc: ->
		console.log @bDesc
		return @bDesc
	increaseCost: ->
		@cost = @cost*1.15
	setMod: (number) ->
		@modifier = number


buildingInsert = (type, cost, modifier, buttonID, bD) ->
	console.log("KEK")
	built = false
	unless buildings.length == 0
		for i in buildings
			if i.getName() == type
				i.purchase()
				built = true
	unless built
		temp = new Building(type, cost, modifier, buttonID, bD)
		buildings.push(temp)
		temp.purchase()



		