return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['vitalis'] = {
		label = 'Potion Vitalis',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['burger'] = {
		label = 'Burger',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 2000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		}
	},

	['identification'] = {
		label = 'Carte d\'Identité',
		client = {
			image = 'card_id.png'
		}
	},

	['money'] = {
		label = 'Piéce d\'Or',
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	--WAND AND SPELL
		['wand'] = {
		label = 'Baguette',
		description = 'Une baguette magique un peu banale',
		weight = 500,
		client = {
			image = 'wand.png',
			export = 'ox_inventory.wand'
		}
	},

	['fireball_spell'] = {
			label = 'Boule de Feu',
			weight = 0.1,
			stack = false,
			close = false,
			description = 'Un sort de boule de feu',
			client = {
					-- Métadonnées personnalisées pour le script de sorts
					spellData = {
							name = 'Boule de Feu',
							damage = 50,
							range = 100.0,
							cooldown = 5000,
							fx = {
                trail = "scr_fbi3_fire",
                impact = "scr_exp_grnd"
							},
							image = 'fireball.png',
							export = 'ox_inventory.fireball'
					}
			}
	},
	['icebolt_spell'] = {
			label = 'Trait de Glace',
			weight = 0.1,
			stack = true,
			close = true,
			description = 'Un sort de projectile de glace',
			client = {
					spellData = {
							name = 'Trait de Glace',
							damage = 30,
							range = 80.0,
							cooldown = 3000,
							fx = {
                trail = "scr_mg_blast",
                impact = "scr_exp_grm"
							},
							image = 'iceball.png',
							export = 'ox_inventory.icebolt'
					}
			}
	}
}