DIST_SUBDIRS = 

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS)
AM_CXXFLAGS = $(HARDENED_CXXFLAGS)
AM_CPPFLAGS = $(HARDENED_CPPFLAGS) -DENABLE_WALLET

if EMBEDDED_LEVELDB
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/include
LEVELDB_CPPFLAGS += -I$(srcdir)/leveldb/helpers/memenv
LIBLEVELDB += $(builddir)/leveldb/libleveldb.a
LIBMEMENV  += $(builddir)/leveldb/libmemenv.a

# NOTE: This dependency is not strictly necessary, but without it make may try to build both in parallel, which breaks the LevelDB build system in a race
$(LIBLEVELDB): $(LIBMEMENV)

$(LIBLEVELDB) $(LIBMEMENV):
	@echo "Building LevelDB ..." && $(MAKE) -C $(@D) $(@F) CXX="$(CXX)" \
	  CC="$(CC)" PLATFORM=$(TARGET_OS) AR="$(AR)" $(LEVELDB_TARGET_FLAGS) \
          OPT="$(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) $(AM_CPPFLAGS) $(CPPFLAGS) -D__STDC_LIMIT_MACROS"
endif

NEXCHANGECOIN_CONFIG_INCLUDES=-I$(builddir)/config
NEXCHANGECOIN_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

LIBNEXCHANGECOIN_SERVER=libnexchangecoin_server.a
LIBNEXCHANGECOIN_WALLET=libnexchangecoin_wallet.a
LIBNEXCHANGECOIN_COMMON=libnexchangecoin_common.a
LIBNEXCHANGECOIN_CLI=libnexchangecoin_cli.a
LIBNEXCHANGECOIN_UTIL=libnexchangecoin_util.a
LIBNEXCHANGECOIN_CRYPTO=crypto/libnexchangecoin_crypto.a
LIBNEXCHANGECOINQT=qt/libnexchangecoinqt.a

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES = \
  crypto/libnexchangecoin_crypto.a \
  libnexchangecoin_util.a \
  libnexchangecoin_common.a \
  libnexchangecoin_server.a \
  libnexchangecoin_cli.a
if ENABLE_WALLET
NEXCHANGECOIN_INCLUDES += $(BDB_CPPFLAGS)
#EXTRA_LIBRARIES += libnexchangecoin_wallet.a
endif
if ENABLE_ZMQ
#EXTRA_LIBRARIES += libnexchangecoin_zmq.a
endif

if BUILD_NEXCHANGECOIN_LIBS
lib_LTLIBRARIES = libnexchangecoinconsensus.la
LIBNEXCHANGECOIN_CONSENSUS=libnexchangecoinconsensus.la
else
LIBNEXCHANGECOIN_CONSENSUS=
endif

bin_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_NEXCHANGECOIND
  bin_PROGRAMS += nexchangecoind
endif

if BUILD_NEXCHANGECOIN_UTILS
#  bin_PROGRAMS += nexchangecoin-cli nexchangecoin-tx
#   these don't exist yet
endif

.PHONY: FORCE
# nexchangecoin core #
NEXCHANGECOIN_CORE_H = \
  addrman.h \
  alert.h \
  allocators.h \
  arith_uint256.h \
  base58.h \
  bignum.h \
  chainparams.h \
  chainparamsseeds.h \
  checkpoints.h \
  clientversion.h \
  coincontrol.h \
  compat.h \
  core.h \
  crypter.h \
  db.h \
  hash.h \
  init.h \
  kernel.h \
  key.h \
  keystore.h \
  main.h \
  miner.h \
  mruset.h \
  netbase.h \
  net.h \
  pbkdf2.h \
  protocol.h \
  rpcclient.h \
  rpcprotocol.h \
  rpcserver.h \
  script.h \
  scrypt.h \
  serialize.h \
  sync.h \
  threadsafety.h \
  timedata.h \
  tinyformat.h \
  txdb.h \
  txdb-leveldb.h \
  txmempool.h \
  ui_interface.h \
  uint256.h \
  util.h \
  version.h \
  walletdb.h \
  wallet.h \
  json/json_spirit_error_position.h \
  json/json_spirit.h \
  json/json_spirit_reader.cpp \
  json/json_spirit_reader.h \
  json/json_spirit_reader_template.h \
  json/json_spirit_stream_reader.h \
  json/json_spirit_utils.h \
  json/json_spirit_value.cpp \
  json/json_spirit_value.h \
  json/json_spirit_writer.cpp \
  json/json_spirit_writer.h \
  json/json_spirit_writer_template.h


obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libnexchangecoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between nexchangecoind and nexchangecoin-qt
# For now we REQUIRE the wallet sources for building. XXX
libnexchangecoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libnexchangecoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) -I$(srcdir)/leveldb/helpers/
libnexchangecoin_server_a_SOURCES = \
  addrman.cpp \
  alert.cpp \
  checkpoints.cpp \
  crypter.cpp \
  db.cpp \
  init.cpp \
  kernel.cpp \
  main.cpp \
  miner.cpp \
  net.cpp \
  noui.cpp \
  pbkdf2.cpp \
  rpcblockchain.cpp \
  rpcclient.cpp \
  rpcdump.cpp \
  rpcmining.cpp \
  rpcmisc.cpp \
  rpcnet.cpp \
  rpcrawtransaction.cpp \
  rpcserver.cpp \
  rpcwallet.cpp \
  scrypt.cpp \
  timedata.cpp \
  txdb-leveldb.cpp \
  txmempool.cpp \
  wallet.cpp \
  walletdb.cpp \
  $(NEXCHANGECOIN_CORE_H)


# wallet: shared between nexchangecoind and nexchangecoin-qt, but only linked
# when wallet enabled
# Including the leveldb helpers directly is definitely hacky, but it works for now.
libnexchangecoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
libnexchangecoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) -I$(srcdir)/leveldb/helpers/
libnexchangecoin_wallet_a_SOURCES = \
  crypter.cpp \
  db.cpp \
  rpcdump.cpp \
  walletdb.cpp \
  txdb-leveldb.cpp \
  rpcwallet.cpp \
  wallet.cpp \
  scrypt.cpp \
  $(NEXCHANGECOIN_CORE_H)

# crypto primitives library
crypto_libnexchangecoin_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_CONFIG_INCLUDES)
crypto_libnexchangecoin_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libnexchangecoin_crypto_a_SOURCES = 

# common: shared between nexchangecoind, and nexchangecoin-qt and non-server tools
libnexchangecoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
libnexchangecoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libnexchangecoin_common_a_SOURCES = \
  chainparams.cpp \
  core.cpp \
  hash.cpp \
  key.cpp \
  keystore.cpp \
  netbase.cpp \
  protocol.cpp \
  script.cpp \
  $(NEXCHANGECOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libnexchangecoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
libnexchangecoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libnexchangecoin_util_a_SOURCES = \
  version.cpp \
  rpcprotocol.cpp \
  sync.cpp \
  util.cpp \
  $(NEXCHANGECOIN_CORE_H)

if GLIBC_BACK_COMPAT
#libnexchangecoin_util_a_SOURCES += compat/glibc_compat.cpp
endif

# cli: shared between nexchangecoin-cli and nexchangecoin-qt
libnexchangecoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
libnexchangecoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libnexchangecoin_cli_a_SOURCES = \
  rpcclient.cpp \
  $(NEXCHANGECOIN_CORE_H)

nodist_libnexchangecoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# nexchangecoind binary #
nexchangecoind_SOURCES = bitcoind.cpp
nexchangecoind_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
nexchangecoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
nexchangecoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
#nexchangecoind_SOURCES += nexchangecoind-res.rc
endif

nexchangecoind_LDADD = \
  $(LIBNEXCHANGECOIN_SERVER) \
  $(LIBNEXCHANGECOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBNEXCHANGECOIN_UTIL) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)
# retired LDADD
# LIBNEXCHANGECOIN_CRYPTO

if ENABLE_ZMQ
nexchangecoind_LDADD += $(LIBNEXCHANGECOIN_ZMQ) $(ZMQ_LIBS)
endif

if ENABLE_WALLET
#nexchangecoind_LDADD += libnexchangecoin_wallet.a
endif

nexchangecoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS)

# nexchangecoin-cli binary #
nexchangecoin_cli_SOURCES = nexchangecoin-cli.cpp
nexchangecoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES) $(EVENT_CFLAGS)
nexchangecoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
nexchangecoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
nexchangecoin_cli_SOURCES += nexchangecoin-cli-res.rc
endif

nexchangecoin_cli_LDADD = \
  $(LIBNEXCHANGECOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBNEXCHANGECOIN_UTIL)

nexchangecoin_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# nexchangecoin-tx binary #
nexchangecoin_tx_SOURCES = nexchangecoin-tx.cpp
nexchangecoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(NEXCHANGECOIN_INCLUDES)
nexchangecoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
nexchangecoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
nexchangecoin_tx_SOURCES += nexchangecoin-tx-res.rc
endif

nexchangecoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBNEXCHANGECOIN_COMMON) \
  $(LIBNEXCHANGECOIN_UTIL) \
  $(LIBNEXCHANGECOIN_CRYPTO) \
  $(LIBSECP256K1)

nexchangecoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# nexchangecoinconsensus library #
if BUILD_NEXCHANGECOIN_LIBS
include_HEADERS =
libnexchangecoinconsensus_la_SOURCES = \
  hash.cpp \
  script.cpp \
  scrypt.cpp

if GLIBC_BACK_COMPAT
#  libnexchangecoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libnexchangecoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libnexchangecoinconsensus_la_LIBADD = $(LIBSECP256K1)
libnexchangecoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -DBUILD_NEXCHANGECOIN_INTERNAL
libnexchangecoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CLEANFILES = leveldb/libleveldb.a leveldb/libmemenv.a
CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = leveldb

clean-local:
	-$(MAKE) -C leveldb clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h

.rc.o:
	@test -f $(WINDRES)
	$(AM_V_GEN) $(WINDRES) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) -c -o $@ $<

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(abspath $(<D) $<)

if ENABLE_TESTS
#include Makefile.test.include
endif

if ENABLE_BENCH
#include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
#include Makefile.qttest.include
endif

