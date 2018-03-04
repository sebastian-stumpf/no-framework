package Api::App::Config;
use Moose;
use 5.16.0;
use Carp;

has verbose => (
    is => 'ro',
    isa => 'Bool',
    required => 1,
    default => sub { 1 }
);


__PACKAGE__->meta->make_immutable;

1;
