pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function make_fighter()
  local f = {["components"]= {
    {["name"] = "head", ["sprite"] = 0, ["x"] = 0, ["y"] = 0},
    {["name"] = "torso", ["sprite"] = 16, ["x"] = 0, ["y"] = 8},
    {["name"] = "arm", ["sprite"] = 17, ["x"] = 1, ["y"] = 9},
    {["name"] = "leg", ["sprite"] = 32, ["x"] = 0, ["y"] = 16}
  } }
  f.x = 64
  f.y = 64
  return f
end

function compose_sprite(s)
  for component in all(s.components) do
    spr(component.sprite, s.x + component.x, s.y + component.y)
  end
end

function _init()
  _update = game_update
  _draw = game_draw
  player = make_fighter()
end

function title_update()

end

function title_draw()

end

function game_update()

end

function game_draw()
  cls()
  compose_sprite(player)
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
05566600556600005566000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666650566500005665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666650565550005655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566665056665f405666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566665055666f4055666f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0566650000555f4005566f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
056665000000000000555f4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
55555500555555005555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05666500056665000566650000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665500056665000566655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000056665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000005665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05665000005665000005665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00565550000565550005555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
05555550005555550000555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000