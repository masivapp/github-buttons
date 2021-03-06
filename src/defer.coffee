import {
  document
} from "./alias"
import {
  onceEvent
} from "./event"

### istanbul ignore next ###
defer = (func) ->
  if /m/.test(document.readyState) or (!/g/.test(document.readyState) and !document.documentElement.doScroll)
    setTimeout func
  else
    if document.addEventListener
      onceToken = 0
      callback = ->
        func() if !onceToken and onceToken = 1
        return
      onceEvent document, "DOMContentLoaded", callback
      onceEvent window, "load", callback
    else
      callback = ->
        if /m/.test document.readyState
          document.detachEvent "onreadystatechange", callback
          func()
        return
      document.attachEvent "onreadystatechange", callback
  return

export {
  defer
}
