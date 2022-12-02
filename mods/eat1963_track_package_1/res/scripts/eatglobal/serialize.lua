--- Serialize
-- @author UG, Enno Sylvester (Anpassung von UG-Code)
-- @copyright 2017
-- @module eatglobal.serialize

local serialize = {
	version = "1.3",
}

local function doSerialize(object)
	local function _serialize(_object, _prefix, _stack)
		local object_type = type(_object)
		if (object_type == "nil") then
			_stack[#_stack + 1] = "nil"
		elseif object_type == "boolean" then
			_stack[#_stack + 1] = tostring(_object)
		elseif object_type == "number" then
			_stack[#_stack + 1] = _object
		elseif object_type == "string" then
			_stack[#_stack + 1] = string.format("%q", _object)
		elseif object_type == "table" then
			_stack[#_stack + 1] = "{\n"
			local prefix2 = _prefix .. "\t"
			_stack[#_stack + 1] = prefix2

			local indices = {}

			for i = 1, #_object do
				indices[i] = 0
				if (_object[i] ~= nil) then
					_serialize(_object[i], prefix2, _stack)
					_stack[#_stack + 1] = ", "
				end
			end
						
			local keys = {}
			for k in pairs(_object) do
				if indices[k] == nil then	    				
					table.insert(keys, k)
				end
			end
			table.sort(keys)

			for i, k in ipairs(keys) do
				v = _object[k]
				if type(k) == "string" and string.find(k, "^[_%a][_%w]*$") then
					_stack[#_stack + 1] = k.." = "
				else
					_stack[#_stack + 1] = "["
					_serialize(k, prefix2, _stack)
					_stack[#_stack + 1] = "] = "
				end
				_serialize(v, prefix2, _stack)
				_stack[#_stack + 1] = ",\n"..prefix2
			end			

			_stack[#_stack + 1] = "\n".._prefix.."}"
		elseif object_type == "function" then
			_stack[#_stack + 1] = "'function () [....]'"
		else
			_stack[#_stack + 1] = "'"..object_type.." ....'"
		end
	end
	
	local stack = {}
	_serialize(object, "", stack)
	return table.concat(stack)
end

--- Serialisiert 'object' und gibt die "reinen" Daten zurück
--	Format:	{
--						value1, value2, etc.
--					}
-- @serialize.serializeBlanc
-- @param object
-- @return String
function serialize.serializeBlanc(object)
	return doSerialize(object)
end

--- Serialisiert 'object' und gibt Data-Format zurück
--	Format:	function data()
--						return {
--							value1, value2, etc.
--						}
--					end
-- @serialize.serializeDatafmt
-- @param object
-- @return String
function serialize.serializeDatafmt(object)
	return "function data()\nreturn "..doSerialize(object).."\nend\n"
end

--- Serialisiert 'object' und gibt Return-Format zurück
--	Format:	return {
--						value1, value2, etc.
--					}
-- @serialize.serializeReturnfmt
-- @param object
-- @return String
function serialize.serializeReturnfmt(object)
	return "return "..doSerialize(object).."\n"
end

--- Serialisiert 'object' und gibt Table-Format zurück
--	Format:	local nameOfTable or "table" =
--						{
--							value1, value2, etc.
--						}
-- @serialize.serializeTablefmt
-- @param object
-- @param nameOfTable
-- @return String
function serialize.serializeTablefmt(object, nameOfTable)
	return "local "..(nameOfTable or "table").." = "..doSerialize(object).."\n"
end

--- Serialisiert 'object' und gibt Table/Return-Format zurück
--	Format:	local nameOfTable or "table" =
--						{
--							value1, value2, etc.
--						}
--
--						return nameOfTable or "table"
-- @serialize.serializeTablefmt_Returnfmt
-- @param object
-- @param nameOfTable
-- @return String
function serialize.serializeTablefmt_Returnfmt(object, nameOfTable)
	return "local "..(nameOfTable or "table").." = "..doSerialize(object).."\n\nreturn "..(nameOfTable or "table")
end

return serialize