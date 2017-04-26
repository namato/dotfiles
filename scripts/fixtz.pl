#!/usr/bin/perl -w
#################################
### A Simple regex program to ###
### change from one timezone  ###
### to another with ics files ###
###                           ###
###         Shawn Dyjak       ###
###     dyjaks@gmail.com      ###
#################################

use Time::Local;
$infile = $ARGV[0];
$outfile = $ARGV[1];
if (!$infile || !$outfile) {
    print "Welcome to tz_convert. You must specify files to use!\n";
    print "Usage : perl tz_convert <read file> <output file>\n";
    exit;
}
open(INFILE, "+<$infile") or die $!;
my @lines = <INFILE>;
$count = 0;
foreach (@lines) {
    # clean TZID if needed
    s/[;]?TZID=".*"//;
    if ($_ =~ /DTSTART:(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})/) {
        my ($year, $mon, $day, $hour, $min) =
            $_ =~ /(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})/;
        my $time = timegm(0, $min, $hour, $day, $mon- 1, $year - 1900);
        (undef, $min, $hour, $day, $mon, $year) = localtime($time);
        my $local_date = sprintf "%d%02d%02dT%02d%02d00Z\n", $year + 1900, $mon + 1, $day, $hour, $min;
        $lines[$count] = "DTSTART:$local_date";
    } elsif ($_ =~ /DTEND:(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})/) {
        my ($year, $mon, $day, $hour, $min) =
            $_ =~ /(\d{4})(\d{2})(\d{2})T(\d{2})(\d{2})/;
        my $time = timegm(0, $min, $hour, $day, $mon- 1, $year - 1900);
        (undef, $min, $hour, $day, $mon, $year) = localtime($time);
        my $local_date = sprintf "%d%02d%02dT%02d%02d00Z\n", $year + 1900, $mon + 1, $day, $hour, $min;
        $lines[$count] = "DTEND:$local_date";
    } elsif ($_ =~ /DTSTART;VALUE=DATE:(\d{8})/) {
        $lines[$count] = "DTSTART:$1\n";
    } elsif ($_ =~ /DTEND;VALUE=DATE:\d{8}/) {
        $lines[$count] = "";
    }
    $count++;
}
close(INFILE);
open(INFILE, ">$outfile") or die $!;
$count = 0;
    foreach (@lines) {
        print INFILE "$lines[$count]";
        $count++;
    }
close(INFILE);

