local ffi          = require "ffi"
local ffi_new      = ffi.new

local ffi_load     = ffi.load
local ffi_cdef     = ffi.cdef


local OTP_SUCCESS = 0x00000000;
local OTP_ERR_INVALID_PARAMETER = 0x00000001;
local OTP_ERR_CHECK_PWD = 0x00000002;
local OTP_ERR_SYN_PWD = 0x00000003;
local OTP_ERR_REPLAY = 0x00000004;

ffi_cdef[[

    typedef uint64_t authnum_t;
    int  ET_CheckPwdz201(char *authkey, uint64_t t, uint64_t t0,
        unsigned int x, int drift, int authwnd, uint64_t lastsucc,
        const char *otp, int otplen, uint64_t *currsucc, int *currdft);

    int  ET_Syncz201(char *authkey, uint64_t t, uint64_t t0,
            unsigned int x, int drift, int syncwnd, uint64_t lastsucc,
            const char *otp1, int otp1len, const char *otp2, int otp2len,
            uint64_t *currsucc, int *currdft);
]]


local lib = ffi_load "libetotpverify"

local z210 = {}
local mt   = {}


function z210.index()
    return "z210 validate"
end

--验证接口
function z210.validate( authkey, ntime,drift,lastsucc,otp)

    local currsucc = ffi.new("uint64_t[1] ",{0})

    local currdft = ffi.new("int[1]", {1})


    if OTP_SUCCESS == lib.ET_CheckPwdz201( ffi.cast("char *", authkey),ntime,0,60,drift,20,lastsucc,ffi.cast("const char *", otp),#otp, currsucc,currdft) then
        return  true ,tonumber(currsucc[0]),tonumber(currdft[0])
    else
        return false
    end
end

--同步接口
function z210.sync( authkey, ntime,drift,lastsucc,otp1,otp2)

    local currsucc = ffi.new("uint64_t[1] ",{0})

    local currdft = ffi.new("int[1]", {1})

    if OTP_SUCCESS == lib.ET_Syncz201( ffi.cast("char *", authkey),ntime,0,60,drift,40,lastsucc,ffi.cast("const char *", otp1),#otp1,ffi.cast("const char *", otp2),#otp2, currsucc,currdft) then
        return  true ,tonumber(currsucc[0]),tonumber(currdft[0])
    else
        return false
    end
end

mt.__call = z210.index

return setmetatable(z210, mt)
