package Api::App::Controllers;
use Moose;
use 5.16.0;
use Carp;

use Moose::Util::TypeConstraints qw/role_type/;
role_type('Api::App::Controller');

has map => (
    is => 'ro',
    isa => 'HashRef[Api::App::Controller]',
    required => 1,
    traits => ['Hash'],
    handles => {
        get_controller => 'get'
    }
);

sub dispatch {
    my $self = shift;
    my $req = shift;

    my ($name, $action) = $req->path =~ m#^/api/(\w+)/(\w+)$#;
    return return_404() unless $name && $action;
    $action = $req->method . '_' . $action;

    my $controller = $self->get_controller($name);
    return return_404() unless $controller->can($action);

    $controller->$action($req);
}

sub controller_to_key {
    my $cls = shift;
    my $controller = shift;

    return lc($1) if $controller =~ m/^Api::App::Controller::(.+)$/;
}

sub return_error {
    my $code = shift;
    my $message = shift;
    return [$code, ['Content-Type' => 'text/plain'], [$message]];
}

sub return_404 {
    return_error(404, 'Not found');
}


__PACKAGE__->meta->make_immutable;

1;
