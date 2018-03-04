package Api::App::Logger;
use Moose;
use 5.16.0;
use Carp;

has config => (
    is => 'ro',
    isa => 'Api::App::Config',
    required => 1
);

sub info {
    my $self = shift;
    my $string = shift;

    return unless $self->config->verbose;
    say STDERR localtime time . ' [info] '. $string;
}

__PACKAGE__->meta->make_immutable;

1;
