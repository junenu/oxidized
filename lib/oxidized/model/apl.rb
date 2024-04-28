# Operation not confirmed for APL
# APL(ApresiaLight) is a network device from Apresia Systems, Ltd.

class apl < Oxidized::Model
    using Refinements

    prompt /^(\([\w.-]*\)\s[#$]|^\S+[$#]\s?)$/
    comment '! '
    
    cmd 'show running-config' do |cfg|
        cfg = cfg.each_line.to_a[3..-2].join
        cfg
    end

    cfg :telnet do
        username /^Username:/
        password /^Password:/
    end

    cfg :telnet, :ssh do
        pre_logout 'exit' do |cfg|
            send "exit\n"
        end
    end
end
