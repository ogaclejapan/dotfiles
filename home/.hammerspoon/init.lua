-- modifier key as trigger
local modifierKey = 'alt'

local function keyCode(key, modifiers)
  modifiers = modifiers or {}
  return function()
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), true):post()
    hs.timer.usleep(1000)
    hs.eventtap.event.newKeyEvent(modifiers, string.lower(key), false):post()
  end
end

local function remapKey(modifiers, key, keyCode)
  hs.hotkey.bind(modifiers, key, keyCode, nil, keyCode)
end

local function triggerKey(modifiersFrom, keyFrom, keyTo, modifiersTo)
  modifiersFrom = modifiersFrom or {}
  local mods = { table.unpack(modifiersFrom) }
  table.insert(mods, modifierKey)
  remapKey(mods, keyFrom, keyCode(keyTo, modifiersTo or modifiersFrom))
end

local function bindKey(keyFrom, keyTo)
  triggerKey({}, keyFrom, keyTo)
end

local function bindKeys(keyFrom, keyTo)
  triggerKey({}, keyFrom, keyTo)
  triggerKey({'shift'}, keyFrom, keyTo)
  triggerKey({'cmd'}, keyFrom, keyTo)
  triggerKey({'ctrl'}, keyFrom, keyTo)
  triggerKey({'shift', 'cmd'}, keyFrom, keyTo)
  triggerKey({'shift', 'ctrl'}, keyFrom, keyTo)
  triggerKey({'shift', 'cmd', 'ctrl'}, keyFrom, keyTo)
  triggerKey({'cmd', 'ctrl'}, keyFrom, keyTo)
end

local function bindMovementKeys(keyFrom, keyTo, modifiersTo)
  modifiersTo = modifiersTo or {}
  triggerKey({}, keyFrom, keyTo, modifiersTo)
  local mods = { table.unpack(modifiersTo) }
  table.insert(mods, 'shift')
  triggerKey({'shift'}, keyFrom, keyTo, mods)
end

local function enablePrefixKeyForTmux()
  remapKey({modifierKey}, ';', keyCode('b', {'ctrl'}))
end

local function enablePrefixKeyForIdea()
  remapKey({modifierKey}, ';', keyCode('i', {'cmd'}))
end

local function disablePrefixKey()
  remapKey({modifierKey}, ';', keyCode(';', {modifierKey}))
end

local function handleGlobalAppEvent(name, event, app)
  if event == hs.application.watcher.activated then
    -- hs.logger.new('activated app', 'debug').d(name)
    if name == 'iTerm2' then
      enablePrefixKeyForTmux()
    elseif name == 'Android Studio' then
      enablePrefixKeyForIdea()
    else
      disablePrefixKey()
    end
  end
end


--/ カーソル移動 /--

bindMovementKeys('h', 'left')
bindMovementKeys('j', 'down')
bindMovementKeys('k', 'up')
bindMovementKeys('l', 'right')
bindMovementKeys(',', 'left',  {'cmd'})
bindMovementKeys('.', 'right', {'cmd'})
bindMovementKeys('[', 'up',    {'cmd'})
bindMovementKeys(']', 'down',  {'cmd'})
bindMovementKeys('u', 'pageup')
bindMovementKeys('n', 'pagedown')
bindMovementKeys('i', 'left',  {'alt'})
bindMovementKeys('o', 'right', {'alt'})


--/ 仮想Fnキー /--

bindKeys('1', 'f1')
bindKeys('2', 'f2')
bindKeys('3', 'f3')
bindKeys('4', 'f4')
bindKeys('5', 'f5')
bindKeys('6', 'f6')
bindKeys('7', 'f7')
bindKeys('8', 'f8')
bindKeys('9', 'f9')
bindKeys('0', 'f10')
bindKeys('-', 'f11')
bindKeys('=', 'f12')

appsWatcher = hs.application.watcher.new(handleGlobalAppEvent)
appsWatcher:start()

