_crow = {}

function _crow.init()
  crow.init()
  crow.clear()
  crow.reset()
  crow.output[2].action = "pulse(.025, 5, 1)"
  crow.output[4].action = "pulse(.025, 5, 1)"
  crow.ii.pullup(true)
  crow.ii.jf.mode(1)
end

function _crow:jf(note)
  if not fn.is_int(note) then return end
        print("aye")
crow.ii.jf.play_note(1, 5)
  -- crow.ii.jf.play_note((music:snap_note(music:transpose_note(note)) - 60) / 12, 5)
end

function _crow:play(note, pair)
  if not fn.is_int(note) then return end
  local output_pairs = {{1,2},{3,4}}
  print("CROW:PLAY", note, pair)
  crow.output[output_pairs[pair][1]].volts = (note - 60) / 12
  crow.output[output_pairs[pair][2]].execute()
end

return _crow