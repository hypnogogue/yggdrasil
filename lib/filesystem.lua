filesystem = {}

function filesystem.init()
  filesystem.paths = {
    save_path = config.settings.save_path,
    sample_path = config.settings.sample_path,
    factory_path = config.settings.factory_path,
    factory_bank = config.settings.sample_path .. "factory/"
  }
  for k, path in pairs(filesystem.paths) do
    if util.file_exists(path) == false then
      util.make_dir(path)
    end
  end
  filesystem:copy_factory_bank()
end


function filesystem:load()
  local filename = self:get_save_path() .. self:get_load_file()
  local file = assert(io.open(filename, "r"))
  local col = {}
  for line in file:lines() do
    col[#col + 1] = line:gsub("%s+", "")
  end
  file:close()
  tracker:load_track(1, col)
end

function filesystem:set_load_file(s)
  self.load_file = s
end

function filesystem:get_load_file()
  return self.load_file
end

function filesystem:set_save_path(s)
  self.paths.save_path = s
end

function filesystem:get_save_path()
  return self.paths.save_path
end

function filesystem:set_sample_path(s)
  self.paths.sample_path = s
end

function filesystem:get_sample_path()
  return self.paths.sample_path
end

function filesystem:scandir(directory)
  local i, t, popen = 0, {}, io.popen
  local pfile = popen('ls -a "' .. directory .. '"')
  for filename in pfile:lines() do
    if filename ~= "." and filename ~= ".." then
      i = i + 1
      t[i] = filename
    end
  end
  pfile:close()
  return t
end

function filesystem:copy_factory_bank()
  for k, sample in pairs(self:scandir(config.settings.factory_path)) do
    util.os_capture("cp" .. " " .. self.paths.factory_path .. sample .. " " .. self.paths.factory_bank)
  end
end

return filesystem
