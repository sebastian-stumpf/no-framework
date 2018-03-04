package Api;
use strict;
use warnings;
use 5.16.0;
use Carp;
use parent qw/Plack::Component/;
use Plack::Util::Accessor qw/app/;

use Api::Ioc;

sub call {
    my $self = shift;
    my $env = shift;
    $self->app->process($env);
}

sub prepare_app {
    my $self = shift;
    my $app = Api::Ioc->new->resolve(service => 'app');
    $self->app($app);
}

1;
