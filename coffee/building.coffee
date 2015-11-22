buildings = []

class Building
	constructor: (@name, @cost, @modifier, @buttonID, @bDesc) ->
		@built = false
		@amount = 0
	purchase: ->	
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
		return @cost
	getNum: ->
		return @amount
	getButtonId: ->
		return @buttonID
	getDesc: ->
		return @bDesc
	increaseCost: ->
		@cost = @cost*1.15
	setMod: (number) ->
		@modifier = number


buildingInsert = (type, cost, modifier, buttonID, bD) ->
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



		