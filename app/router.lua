-- 业务路由管理
local z210 = require("app.libs.z210")
local DB = require("app.libs.db")
local db = DB:new()

return function(app)

    -- welcome to otp!
    app:get("/", function(req, res, next)
        res:send("hello world!")

    end)


    app:post("/validate", function(req, res, next)

        local no = req.body.no
        local pass = req.body.pass

        if not no then
            return res:json({
                success = false,
                msg = "Key bumber is not  empty"
            })
        end

        if not pass then
            res:json({
                success = false,
                msg = "Pass bumber is not  empty"
            })
            return
        end


        local result, err = db:select("select *  from yc_otp where   no=? limit 1",{no})

    	if not result or err or type(result) ~= "table" or #result <= 0 then
            res:json({
                success = false,
                msg = "Key is not  found"
            })
            return
        else
            local ntime = ngx.time()
            local bool,currsucc,currdft =z210.validate(result[1].authkey,ntime,tonumber(result[1].currdft),tonumber(result[1].currsucc),pass)

            if bool == true then
                db:update("UPDATE yc_otp SET currsucc = ?,currdft=? WHERE id = ?",{currsucc,currdft,result[1].id})

                res:json({
                    success = true
                })

            else
                res:json({
                    success = false
                })
            end

        end

    end)

    app:post('/register',function(req, res, next)

        local no = req.body.no
        local authkey = req.body.authkey

        if not no then
            return res:json({
                success = false,
                msg = "Key bumber is not  empty"
            })
        end

        if not authkey then
            res:json({
                success = false,
                msg = "authkey bumber is not  empty"
            })
            return
        end

        local result, err = db:select("select *  from yc_otp where   no=? and authkey=?  ",{no,tostring(authkey)})

    	if not result or err or type(result) ~= "table" or #result <= 0 then
            local result1,err  = db:insert("insert into yc_otp(no, authkey, upadte_time) values(?,?,?)",
                                {tonumber(no), tostring(authkey), tonumber(ngx.time())})
            res:json({
                success = true
            })
            return

        else

            res:json({
                success = false,
                msg = "Key is   found"
            })
            return

        end

    end)


    app:post('/delete',function(req, res, next)
        local no = req.body.no

        if not no then
            return res:json({
                success = false,
                msg = "Key bumber is not  empty"
            })
        end

        local result, err = db:query("delete from yc_otp where no=? ",
                {no})
        if result and not err then
            res:json({
                success = true
            })
            return
        else
            res:json({
                success = false
            })
        end
    end)



end
