package Api::Ioc;
use Moose;
use 5.16.0;
use Carp;
use Bread::Board;
use Module::Find qw/usesub/;

use Api::App::Controllers;

extends 'Bread::Board::Container';

has '+name' => (default => 'ApiContainer');

sub BUILD {
    my $self = shift;

    container $self => as {
        service config => (
            class => 'Api::App::Config',
            lifecycle => 'Singleton'
        );

        service logger => (
            class => 'Api::App::Logger',
            lifecycle => 'Singleton',
            dependencies => {
                config => depends_on('config')
            }
        );

        service model => (
            class => 'Api::App::Model',
            lifecycle => 'Singleton'
        );

        my @controllers = usesub Api::App::Controller;
        foreach my $mod (@controllers) {
            service $mod => (
                class => $mod,
                lifecycle => 'Singleton',
                dependencies => {
                    config => depends_on('config'),
                    logger => depends_on('logger'),
                    model => depends_on('model')
                }
            );
        }

        service controllers => (
            block => sub {
                my $s = shift;
                my $parent = $s->parent;
                my %map = map {
                    Api::App::Controllers->controller_to_key($_) => $parent->resolve(service => $_);
                } @controllers;
                Api::App::Controllers->new(map => \%map)
            },
            lifecycle => 'Singleton',
        );

        service app => (
            class => 'Api::App',
            lifecycle => 'Singleton',
            dependencies => {
                config => depends_on('config'),
                logger => depends_on('logger'),
                controllers => depends_on('controllers')
            }
        );


    };
}


__PACKAGE__->meta->make_immutable;

1;
