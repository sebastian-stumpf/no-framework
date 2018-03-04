package Api::App::Controller;
use Moose::Role;
use 5.16.0;
use Carp;

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

has model => (
    is => 'ro',
    isa => 'Api::App::Model',
    required => 1
);

1;
