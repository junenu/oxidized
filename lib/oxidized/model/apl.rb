# APL(ApresiaLight) is a network device from Apresia Systems, Ltd.

class Apl < Oxidized::Model

    using Refinements
    prompt /^([\w.@()-]+[#>]\s*)$/
    comment '# '

    cmd 'show running-config' do |cfg|
        cfg = cfg.each_line.to_a[16..-7].join
        cfg
    end

    cfg :telnet do
        username /^User:/
        password /^Password:/
    end

    cfg :telnet, :ssh do
        post_login do
            cmd 'terminal length 0'
            cmd 'terminal width 0'
        end
        pre_logout 'exit'
    end
end
