
package Weasel::Widgets::Dojo::Select;

use strict;
use warnings;

use Weasel::Widgets::HTML::Select;
use Weasel::WidgetHandlers qw/ register_widget_handler /;

use Moose;
extends 'Weasel::Widgets::HTML::Select';

register_widget_handler(__PACKAGE__, 'Dojo',
                        tag_name => 'table',
                        class => 'dijitSelect',
                        attributes => {
                            role => 'listbox',
                        },
    );


sub _option_popup {
    my ($self) = @_;
    my $id = $self->get_attribute('id');
    my $page = $self->session->page;

    my @rv = $page->find_all("//table[\@dijitpopupparent='$id']");

    if (! @rv) { # no elements returned, while we expect one; create the popup
        # make sure the popup gets created by clicking twice (pop up+pop down)
        $self->click;
        $self->click;

        @rv = $page->find_all("//table[\@dijitpopupparent='$id']");
    }

    return (shift @rv);
}



1;
