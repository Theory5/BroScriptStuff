##! This script is to modify conn.log output to only output specific fields
##! as well as include GEO-IP and pcap capture
##! Built (or more accurately, copied and pasted) by Theory
     
@load base/utils/site
@load base/frameworks/files
     
module Conn;
     
    export {
            redef record Conn::Info += {
            ## Country code for the originator of the connection based
            ## on a GeoIP lookup.
            orig_cc: string &optional &log;
            ## Country code for the responser of the connection based
            ## on a GeoIP lookup.
            resp_cc: string &optional &log;
            };
    }
     
event connection_state_remove(c: connection)
            {
            local orig_loc = lookup_location(c$id$orig_h);
            if ( orig_loc?$country_code )
                    c$conn$orig_cc = orig_loc$country_code;
     
            local resp_loc = lookup_location(c$id$resp_h);
            if ( resp_loc?$country_code )
                    c$conn$resp_cc = resp_loc$country_code;
            }
     
event bro_init()
            {
            Log::add_filter(Conn::LOG, [$name="aprilfilter",
                    $exclude=set("uid","duration","orig_bytes","resp_bytes","missed_bytes", "history", "orig_pkts","resp_pkts","resp_ip_bytes")]);
            Log::remove_filter(Conn::LOG, "default");
            Log::remove_filter(HTTP::LOG, "default");
            Log::remove_filter(SSH::LOG, "default");
            Log::remove_filter(SMTP::LOG, "default");
            Log::remove_filter(PacketFilter::LOG, "default");
            }

