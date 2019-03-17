pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

states = {["idle"] = "idle", ["walking"] = "walking", ["punching"] = "punching", ["jumping"] = "jumping", ["landing"]="landing", ["kicking"]="kicking"}
states_preclude = {[states.idle] = {}, [states.walking] = {states.kicking}, [states.punching] = {}, [states.jumping] = {states.walking, states.kicking}, [states.landing]={states.jumping, states.walking, states.kicking}}
ground = 88
gravity = 0.2

function unpack_animation(frames, multiplier)
  local unpacked_frames = {}
  for frame in all(frames) do
    for i=0,multiplier do
	  add(unpacked_frames, frame)
	end
  end
  return unpacked_frames
end

function apply_gravity(s)
  local lastY = s.y 
  s.y += s.vyc
  if s.y + s.height < ground then
    s.vyc += gravity
	else
    if s.y - lastY != 0 then
      land(s)
    end
	  s.vyc = 0
	  s.y = ground - s.height
  end
end

cycles = {
  ["head"] = {
    [states.idle] = {
	  ["loop"] = true,
      ["frames"] = unpack_animation({
        {["sprite"] = 0, ["x"] = 0, ["y"] = 0},
        {["sprite"] = 0, ["x"] = 1, ["y"] = 0},
        {["sprite"] = 0, ["x"] = 1, ["y"] = 1},
        {["sprite"] = 0, ["x"] = 0, ["y"] = 1}
      }, 4)
	},
    [states.landing] = {
      ["loop"] = false,
      ["frames"] = unpack_animation({
        {["sprite"] = 0, ["x"] = 0, ["y"] = 2},
        {["sprite"] = 0, ["x"] = 0, ["y"] = 4},
        {["sprite"] = 0, ["x"] = 0, ["y"] = 1}
      }, 1)
    }
  },
  ["torso"] = {
    [states.idle] = {
	  ["loop"] = true,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 16, ["x"] = 1, ["y"] = 8},
        {["sprite"] = 16, ["x"] = 0, ["y"] = 8},
        {["sprite"] = 16, ["x"] = 0, ["y"] = 8},
        {["sprite"] = 16, ["x"] = 1, ["y"] = 8}		
	  }, 4)
	},
  [states.landing] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 16, ["x"] = 1, ["y"] = 10},
        {["sprite"] = 16, ["x"] = 0, ["y"] = 11},
        {["sprite"] = 16, ["x"] = 0, ["y"] = 9}		
	  }, 2)
	}
  },
  ["arm"] = {
    [states.idle] = {
	  ["loop"] = true,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 17, ["x"] = 0, ["y"] = 9},
		{["sprite"] = 18, ["x"] = 1, ["y"] = 9},
		{["sprite"] = 18, ["x"] = 1, ["y"] = 8},
		{["sprite"] = 17, ["x"] = 0, ["y"] = 8}
	  }, 4)
	},
  [states.landing] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 17, ["x"] = 0, ["y"] = 11},
		  {["sprite"] = 18, ["x"] = 1, ["y"] = 12}
	  }, 2)
	},
	[states.punching] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 18, ["x"] = 2, ["y"] = 9},
	    {["sprite"] = 19, ["x"] = 3, ["y"] = 8},
	    {["sprite"] = 20, ["x"] = 5, ["y"] = 8},
	    {["sprite"] = 20, ["x"] = 4, ["y"] = 7},
	    {["sprite"] = 19, ["x"] = 3, ["y"] = 8}
	  }, 1)
	}
  },
  ["leg_front"] = {
    [states.idle] = {
	  ["loop"] = true,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 32, ["x"] = 0, ["y"] = 16},
		{["sprite"] = 32, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 32, ["x"] = 1, ["y"] = 16}
	  }, 4)
	},
	[states.walking] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 32, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 33, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 34, ["x"] = 1, ["y"] = 16},
		{["sprite"] = 33, ["x"] = 0, ["y"] = 16}
	  }, 4)
	},
	[states.jumping] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
		{["sprite"] = 48, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 14},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 13},
		{["sprite"] = 48, ["x"] = 0, ["y"] = 15}
	  }, 3)
	},
  [states.landing] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
		{["sprite"] = 48, ["x"] = 0, ["y"] = 17},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 18},
		{["sprite"] = 48, ["x"] = 0, ["y"] = 19}
	  }, 1)
	},
	[states.kicking] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
		{["sprite"] = 34, ["x"] = 2, ["y"] = 16},
		{["sprite"] = 35, ["x"] = 3, ["y"] = 14},
		{["sprite"] = 36, ["x"] = 4, ["y"] = 12},
    {["sprite"] = 36, ["x"] = 5, ["y"] = 11},
		{["sprite"] = 35, ["x"] = 3, ["y"] = 13},
    {["sprite"] = 35, ["x"] = 2, ["y"] = 14}
	  }, 1)
  }
  },
  ["leg_back"] = {
    [states.idle] = {
	  ["loop"] = true,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 32, ["x"] = 1, ["y"] = 15},
		{["sprite"] = 32, ["x"] = 1, ["y"] = 16},
		{["sprite"] = 32, ["x"] = 0, ["y"] = 15}
	  }, 4)
	},
	[states.walking] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
		{["sprite"] = 34, ["x"] = 1, ["y"] = 16},
		{["sprite"] = 33, ["x"] = 0, ["y"] = 16},
		{["sprite"] = 32, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 33, ["x"] = 0, ["y"] = 15}
	  }, 4)
	},
	[states.jumping] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
	    {["sprite"] = 33, ["x"] = 0, ["y"] = 16},
		{["sprite"] = 48, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 14},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 13},
		{["sprite"] = 48, ["x"] = 0, ["y"] = 15},
		{["sprite"] = 33, ["x"] = 0, ["y"] = 16}
	  }, 3)
	},
  [states.landing] = {
	  ["loop"] = false,
	  ["frames"] = unpack_animation({
		{["sprite"] = 48, ["x"] = 0, ["y"] = 17},
		{["sprite"] = 49, ["x"] = 1, ["y"] = 19},
		{["sprite"] = 48, ["x"] = 0, ["y"] = 17}
	  }, 1)
	}
  }
}

function make_fighter(take_input, use_input, colour, x, flipped)
  local f = {["components"]= {
    {["name"] = "head", ["def"] = cycles.head, ["state"] = states.idle, ["tick"] = 1},
    {["name"] = "torso", ["def"] = cycles.torso, ["state"] = states.idle, ["tick"] = 1, ["coloured"] = true},
    {["name"] = "arm", ["def"] = cycles.arm, ["state"] = states.idle, ["tick"] = 1, ["coloured"] = true},
    {["name"] = "leg_back", ["def"] = cycles.leg_back, ["state"] = states.idle, ["tick"] = 1, ["coloured"] = true },
	{["name"] = "leg_front", ["def"] = cycles.leg_front, ["state"] = states.idle, ["tick"] = 1, ["coloured"] = true }
  }}
  f.component_map = find_components(f.components)
  f.x = x
  f.y = 64
  f.vx = 0.5
  f.vy = -3
  f.vyc = 0
  f.height = 24
  f.colour = colour
  function f:update()
    local input = take_input()
	use_input(f, input.left, input.right, input.up, input.down, input.fire1, input.fire2)
  end
  return f
end

function player_input()
  return {["left"] = btn(0), ["right"] = btn(1), ["up"] = btn(2), ["down"] = btn(3), ["fire1"] = btn(4), ["fire2"] = btn(5)}
end

function cpu_input()
  return {
    ["left"] = rnd(100) > 98,
    ["right"] = rnd(100) > 98,
    ["up"] = rnd(100) > 98,
    ["down"] = rnd(100) > 98,
    ["fire1"] = rnd(100) > 98,
    ["fire2"] = rnd(100) > 98
  }
end

function check_if_precludes(curr_state, new_state)
  for preclusion in all(states_preclude[curr_state]) do
    if new_state == preclusion then
	  return true
	end
  end
  return false
end

function find_components(components)
  local component_map = {}
  for component in all(components) do
    component_map[component.name] = component
  end
  return component_map
end

function walk(p, direction)
  p.x += direction * p.vx
  if check_if_precludes(p.component_map.leg_back.state, states.walking) == false then
    p.component_map.leg_back.state = states.walking
  end
  if check_if_precludes(p.component_map.leg_front.state, states.walking) == false then
    p.component_map.leg_front.state = states.walking
  end
end

function punch(p)
  if p.component_map.arm.state != states.punching then
    p.component_map.arm.tick = 1
  end  
  p.component_map.arm.state = states.punching
end

function jump(p)
  if p.y + p.height != ground or check_if_precludes(p.component_map.leg_front.state, states.jumping) then
    return
  end
  p.vyc = p.vy
  p.component_map.leg_back.state = states.jumping
  p.component_map.leg_back.tick = 1
  p.component_map.leg_front.state = states.jumping
  p.component_map.leg_front.tick = 1
end

function land(p)
  for c in all(p.components) do
    c.state = states.landing
    c.tick = 1
  end
end

function kick(p)
  if check_if_precludes(p.component_map.leg_front.state, states.kicking) then
    return
  end
  p.component_map.leg_front.state = states.kicking
  p.component_map.leg_front.tick = 1
end

function figher_update_1(p, left, right, up, down, fire1, fire2)
  apply_gravity(p)
  update_tick(p.components)
  if left then
    walk(p, -1)
  end
  if right then
    walk(p, 1)
  end
  if up then
    jump(p)
  end
  if fire1 then
    punch(p)
  end
  if fire2 then
    kick(p)
  end
  process_states(p.components)
end

function update_tick(components)
  for component in all(components) do
    component.tick +=1
  end
end

function process_states(components)
  for component in all(components) do
	if component.tick > #component.def[component.state].frames then
	  component.tick = 1
	  if not component.def[component.state].loop then
	    component.state = states.idle
	  end
	end
  end
end

function get_orientfunc(flipped)
  if flipped then
    return function(v) return 8 - v end
  end
  return function(v) return v end
end

function compose_sprite(s)
  local frame
  local orient_offset = get_orientfunc(s.flipped)
  for component in all(s.components) do
    if component.coloured == true then
      pal(6, s.colour)
    end
    frame = component.def[component.state].frames[component.tick]
    spr(frame.sprite, s.x + orient_offset(frame.x), s.y + frame.y, 1, 1, s.flipped)
    pal()
  end
end

function orient_players(p1, p2)
  if p1.x < p2.x then
    p1.flipped = false
    p2.flipped = true
  else
    p1.flipped = true
    p2.flipped = false
  end
end

function _init()
  _update = game_update
  _draw = game_draw
  player1 = make_fighter(player_input, figher_update_1, 8, 48)
  player2 = make_fighter(cpu_input, figher_update_1, 11, 90)
end

function title_update()

end

function title_draw()

end

function game_update()
  player1:update()
  player2:update()
  orient_players(player1, player2)
end

function game_draw()
  cls()
  draw_background1()
  compose_sprite(player1)
  compose_sprite(player2)
end

function draw_background1()
  rectfill(0,0,128,5,0)
  fillp(0b0101101001011010)
  rectfill(0,6,128,11,0x01)
  fillp()
  rectfill(0,12,128,17,1)
  fillp(0b0101101001011010)
  rectfill(0,18,128,23,0x12)
  fillp()
  rectfill(0,24,128,29,2)
  fillp(0b0101101001011010)
  rectfill(0,30,128,35,0x28)
  fillp()
  rectfill(0,36,128,41,8)
  fillp(0b0101101001011010)
  rectfill(0,42,128,47,0x89)
  fillp()
  rectfill(0,48,128,53,9)
  fillp(0b0101101001011010)
  rectfill(0,54,128,59,0x9a)
  fillp()
  rectfill(0,60,128,65,10)
  fillp(0b0101101001011010.1)
  circfill(64,66,10,7)
  fillp()
  circfill(64,66,8,7)
  rectfill(0,66,128,80,12)
  clip(54,66,20,10)
  fillp(0b0101101001011010.1)
  circfill(64,65,9,15)
  fillp()
  circfill(64,65,5,15)
  clip()
end

__gfx__
02444440024444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
144ff440244ff4400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
244f6f00444656000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
249f5f00249717000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24fffff044f666200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
24ffdd0024f655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14fff60044f561000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
04ff000004ffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05566600556600005566000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666650566500005665000056600000555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666650565550005655000066550000666666f40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566665056665f4056665000666650f4666666f40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566665055666f4055666f4056666ff455555ff40000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566650000555f4005566f40055555f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
056665000000000000555f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555500555555005555550055550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666500056665000566650056660000000005550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665500056665000566655056666055555005550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000056665000566655666555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000005665000056655666666550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000005665000006655665555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00565550000565550005555500000555550000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550005555550000555500000550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555500555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666500056666550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00566650005566650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00056650556656650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
56666500556666550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55565000555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555500555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00555500555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03300000300033300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03333333303330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
30000034533000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000354430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033005453330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000400033000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000400003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00300000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000044440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
