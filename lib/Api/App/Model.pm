package Api::App::Model;
use Moose;
use 5.16.0;
use Carp;

use MooseX::Storage;
with Storage('format' => 'JSON');

has content => (
    is => 'ro',
    isa => 'Str',
    required => 1,
    default => sub {'part of the model'}
);

__PACKAGE__->meta->make_immutable;

1;
