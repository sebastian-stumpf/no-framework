package Api::App;
use Moose;
use 5.16.0;
use Carp;
use Plack::Request;

has config => (
    is => 'ro',
    isa => 'Api::App::Config',
    required => 1
);

has logger => (
    is => 'ro',
    isa => 'Api::App::Logger',
    required => 1
);

has controllers => (
    is => 'ro',
    isa => 'Api::App::Controllers',
    required => 1
);

sub process {
    my $self = shift;
    my $env = shift;

    my $req = Plack::Request->new($env);
    $self->controllers->dispatch($req);
}

__PACKAGE__->meta->make_immutable;

1;
