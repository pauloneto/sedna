package Sedna;

use 5.010000;
use strict;
use warnings;
use Carp;

require Exporter;
use AutoLoader;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	BULK_LOAD_PORTION
	QUERY_EXECUTION_TIME
	SEDNA_AUTHENTICATION_FAILED
	SEDNA_AUTOCOMMIT_OFF
	SEDNA_AUTOCOMMIT_ON
	SEDNA_BEGIN_TRANSACTION_FAILED
	SEDNA_BEGIN_TRANSACTION_SUCCEEDED
	SEDNA_BOUNDARY_SPACE_PRESERVE_OFF
	SEDNA_BOUNDARY_SPACE_PRESERVE_ON
	SEDNA_BULK_LOAD_FAILED
	SEDNA_BULK_LOAD_SUCCEEDED
	SEDNA_CLOSE_SESSION_FAILED
	SEDNA_COMMIT_TRANSACTION_FAILED
	SEDNA_COMMIT_TRANSACTION_SUCCEEDED
	SEDNA_CONNECTION_CLOSED
	SEDNA_CONNECTION_FAILED
	SEDNA_CONNECTION_OK
	SEDNA_DATA_CHUNK_LOADED
	SEDNA_ERROR
	SEDNA_GET_ATTRIBUTE_SUCCEEDED
	SEDNA_NEXT_ITEM_FAILED
	SEDNA_NEXT_ITEM_SUCCEEDED
	SEDNA_NO_ITEM
	SEDNA_NO_TRANSACTION
	SEDNA_OPEN_SESSION_FAILED
	SEDNA_OPERATION_SUCCEEDED
	SEDNA_QUERY_FAILED
	SEDNA_QUERY_SUCCEEDED
	SEDNA_RESET_ATTRIBUTES_SUCCEEDED
	SEDNA_RESULT_END
	SEDNA_ROLLBACK_TRANSACTION_FAILED
	SEDNA_ROLLBACK_TRANSACTION_SUCCEEDED
	SEDNA_SESSION_CLOSED
	SEDNA_SESSION_OPEN
	SEDNA_SET_ATTRIBUTE_SUCCEEDED
	SEDNA_TRANSACTION_ACTIVE
	SEDNA_UPDATE_FAILED
	SEDNA_UPDATE_SUCCEEDED
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our $VERSION = '0.01';

sub AUTOLOAD {
    # This AUTOLOAD is used to 'autoload' constants from the constant()
    # XS function.

    my $constname;
    our $AUTOLOAD;
    ($constname = $AUTOLOAD) =~ s/.*:://;
    croak "&Sedna::constant not defined" if $constname eq 'constant';
    my ($error, $val) = constant($constname);
    if ($error) { croak $error; }
    {
	no strict 'refs';
        *$AUTOLOAD = sub { $val };
    }
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Sedna', $VERSION);

sub setConnectionAttr {
  my ($self, %params) = @_;
  for (keys %params) {
    my $meth = 'setConnectionAttr_'.$_;
    $self->$meth($params{$_});
  }
}

sub getConectionAttr {
  my ($self, @params) = @_;
  return map {
    my $meth = 'setConnectionAttr_'.$_;
    $_ => $self->$meth($_);
  } @params;
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Sedna - Perl extension for Sedna C driver

=head1 SYNOPSIS

  use Sedna;

=head2 Exportable constants

  BULK_LOAD_PORTION
  QUERY_EXECUTION_TIME
  SEDNA_AUTHENTICATION_FAILED
  SEDNA_AUTOCOMMIT_OFF
  SEDNA_AUTOCOMMIT_ON
  SEDNA_BEGIN_TRANSACTION_FAILED
  SEDNA_BEGIN_TRANSACTION_SUCCEEDED
  SEDNA_BOUNDARY_SPACE_PRESERVE_OFF
  SEDNA_BOUNDARY_SPACE_PRESERVE_ON
  SEDNA_BULK_LOAD_FAILED
  SEDNA_BULK_LOAD_SUCCEEDED
  SEDNA_CLOSE_SESSION_FAILED
  SEDNA_COMMIT_TRANSACTION_FAILED
  SEDNA_COMMIT_TRANSACTION_SUCCEEDED
  SEDNA_CONNECTION_CLOSED
  SEDNA_CONNECTION_FAILED
  SEDNA_CONNECTION_OK
  SEDNA_DATA_CHUNK_LOADED
  SEDNA_ERROR
  SEDNA_GET_ATTRIBUTE_SUCCEEDED
  SEDNA_NEXT_ITEM_FAILED
  SEDNA_NEXT_ITEM_SUCCEEDED
  SEDNA_NO_ITEM
  SEDNA_NO_TRANSACTION
  SEDNA_OPEN_SESSION_FAILED
  SEDNA_OPERATION_SUCCEEDED
  SEDNA_QUERY_FAILED
  SEDNA_QUERY_SUCCEEDED
  SEDNA_RESET_ATTRIBUTES_SUCCEEDED
  SEDNA_RESULT_END
  SEDNA_ROLLBACK_TRANSACTION_FAILED
  SEDNA_ROLLBACK_TRANSACTION_SUCCEEDED
  SEDNA_SESSION_CLOSED
  SEDNA_SESSION_OPEN
  SEDNA_SET_ATTRIBUTE_SUCCEEDED
  SEDNA_TRANSACTION_ACTIVE
  SEDNA_UPDATE_FAILED
  SEDNA_UPDATE_SUCCEEDED

=head1 SEE ALSO

The development of the bindings is hosted at http://github.com/ruoso/sedna.
It was based on the quick start guide at http://www.modis.ispras.ru/sedna/c-samples.html.

=head1 AUTHOR

Daniel Ruoso, E<lt>daniel@ruoso.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Daniel Ruoso

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
