# Toucan

For token based account creation and data ownership.

## Motivation

Rather than allowing the company to hold your data, what if data ownership was given to you, the user?
Instead of creating an account, you simply hold up your token to the application, and it lets you in.
With all information stored on (or at least, protected by) your token, there are a number of benefits:
1.  Data ownership: Companies no longer have access to your data when you are not around.
2.  Shared information: Information that you previously had to provide manually to every application is now stored only in one location, and shared only when necessary.
3.  Reverse the two factors: the first factor is now your token. You can still password protect things for a second factor.

## How might this work?

The token itself is basically just a private key, providing the usual capabilities, along with some
associated data storage. This data could be stored directly on the token, on the user's device, or
encrypted and stored on a public server. Using a federated protocol, these storage servers can be
distributed so that users can choose where to store each individual piece of data, allowing them to
decide which storage providers they trust and the level of accessibilty of that data, while allowing
applications to work without needing to be aware of the actual location of the data.

By providing these many options for data storage, we can simultaneously provide sufficient protection
from data loss (in the case of losing the physical token and needing a replacement) by storing the
bulk of the data on public servers, while ensuring that the user's most private information, such
as credit card or social security numbers, is not being shared via the Internet by storing them only
on the token itself. In the case of losing the physical token, the user would likely have a copy of
their credit card information, and can use some secondary authentication to regain access to any other
data they had stored on public servers associated to their lost token. Of course, losing the physical
token would be discouraged, by making the user aware of the consequences being similar to that of
losing their actual credit card or passport.

Applications which wish to integrate with this token or data would use the associated library to do
so, ensuring proper interaction with the token and the data stores and protocols. Though there can be
nothing stopping the application from storing data on its own, it would be recommended to use the
library to access and store of a user's data. Hopefully by promoting open source, and through more
thorough legislation around data ownership, users can make informed decisions on the data they
provide to these applications.

There are some cases in which the application needs to be able to access without user being present,
such as for an online shop: in order to show listings and record purchases, the application will need
to have be able to use the data at all times, not just while the seller is able to approve it at every
access. In this case, the data can be "loaned" to the application: by storing the encrypted data on a
public server, and providing the application with the relevant keys, the application will have access
to the data without owning it. At any time, the user may revoke this access simply by deleting or
re-encrypting the data and not providing the updated keys to the application.

Of course, if the data is owned by and accessible to the user outside of the application, data
integrity on behalf of the application becomes an issue. To address this, some data can be "co-owned"
by the application, allowing the user to view and delete it in its entirety, but not to modify it
without the cooperation of the application. As for maintaining that data across application updates,
this would be the responsibility of the application developer much as it is with traditional data
storaged, likely through similar strategies to database migrations.

The format of the data would largely be up to the application and the storage providers. As some
applications may use a document-based approach, while others prefer a relational database, a graph
structure, or even something else, different formats will certainly be required. I expect storage
providers would declare which formats they support, applications to declare which format they use,
and then leave it up to the user to ensure that such requirements are met by the storage providers
they have selected to hold their data.
