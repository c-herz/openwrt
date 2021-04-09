#!/usr/bin/perl
-e "cortex-a9.mk.orig" and die "Error: cortex-a9.mk.orig already exists";
-e "cortex-a9-neon.mk" and die "Error: cortex-a9-neon.mk already exists";
$signature = "### automatically generated by split-neon.pl from upstream cortex-a9.mk.";
$/='';
open FILE, "<cortex-a9.mk" or die $!;
while (<FILE>) {
    /$signature/ and die "cortex-a9.mk has already been split";
}
close FILE;
rename("cortex-a9.mk","cortex-a9.mk.orig") or die "rename cortex-a9.mk to cortex-a9.mk.orig: $!";
open FILE, "<cortex-a9.mk.orig" or die $!;
open VFP, ">cortex-a9.mk" or die $!;
open NEON, ">cortex-a9-neon.mk" or die $!;
while (<FILE>) {
    print VFP $_ unless /TARGET_DEVICES/ && /armada-38[58]/;
    s/cortexa9/cortexa9neon/;
    print NEON $_ unless /TARGET_DEVICES/ && !/armada-38[58]/;
}
print NEON "$signature\n";
print VFP "$signature\n";
close FILE;
close NEON;
close VFP;
unlink "cortex-a9.mk.orig" or die "Can't remove cortex-a9.mk.orig: $!";
