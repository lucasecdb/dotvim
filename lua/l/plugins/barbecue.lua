require('barbecue').setup {
  symbols = {
    ---Modification indicator.
    ---
    ---@type string
    modified = '●',

    ---Truncation indicator.
    ---
    ---@type string
    ellipsis = '…',

    ---Entry separator.
    ---
    ---@type string
    separator = '',
  },

  ---@alias barbecue.Config.kinds
  ---|false # Disable kind icons.
  ---|table<string, string> # Type to icon mapping.
  ---
  ---Icons for different context entry kinds.
  ---
  ---@type barbecue.Config.kinds
  kinds = {
    File = '',
    Module = '',
    Namespace = '',
    Package = '',
    Class = '',
    Method = '',
    Property = '',
    Field = '',
    Constructor = '',
    Enum = '',
    Interface = '',
    Function = '',
    Variable = '',
    Constant = '',
    String = '',
    Number = '',
    Boolean = '',
    Array = '',
    Object = '',
    Key = '',
    Null = '',
    EnumMember = '',
    Struct = '',
    Event = '',
    Operator = '',
    TypeParameter = '',
  },
}
