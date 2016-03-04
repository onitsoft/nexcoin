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

CM_UpperName_CONFIG_INCLUDES=-I$(builddir)/config
CM_UpperName_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

LIBCM_UpperName_SERVER=libCM_LowerName_server.a
LIBCM_UpperName_WALLET=libCM_LowerName_wallet.a
LIBCM_UpperName_COMMON=libCM_LowerName_common.a
LIBCM_UpperName_CLI=libCM_LowerName_cli.a
LIBCM_UpperName_UTIL=libCM_LowerName_util.a
LIBCM_UpperName_CRYPTO=crypto/libCM_LowerName_crypto.a
LIBCM_UpperNameQT=qt/libCM_LowerNameqt.a

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES = \
  crypto/libCM_LowerName_crypto.a \
  libCM_LowerName_util.a \
  libCM_LowerName_common.a \
  libCM_LowerName_server.a \
  libCM_LowerName_cli.a
if ENABLE_WALLET
CM_UpperName_INCLUDES += $(BDB_CPPFLAGS)
#EXTRA_LIBRARIES += libCM_LowerName_wallet.a
endif
if ENABLE_ZMQ
#EXTRA_LIBRARIES += libCM_LowerName_zmq.a
endif

if BUILD_CM_UpperName_LIBS
lib_LTLIBRARIES = libCM_LowerNameconsensus.la
LIBCM_UpperName_CONSENSUS=libCM_LowerNameconsensus.la
else
LIBCM_UpperName_CONSENSUS=
endif

bin_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_CM_UpperNameD
  bin_PROGRAMS += CM_LowerNamed
endif

if BUILD_CM_UpperName_UTILS
#  bin_PROGRAMS += CM_LowerName-cli CM_LowerName-tx
#   these don't exist yet
endif

.PHONY: FORCE
# CM_LowerName core #
CM_UpperName_CORE_H = \
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
libCM_LowerName_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between CM_LowerNamed and CM_LowerName-qt
# For now we REQUIRE the wallet sources for building. XXX
libCM_LowerName_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libCM_LowerName_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) -I$(srcdir)/leveldb/helpers/
libCM_LowerName_server_a_SOURCES = \
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
  $(CM_UpperName_CORE_H)


# wallet: shared between CM_LowerNamed and CM_LowerName-qt, but only linked
# when wallet enabled
# Including the leveldb helpers directly is definitely hacky, but it works for now.
libCM_LowerName_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
libCM_LowerName_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) -I$(srcdir)/leveldb/helpers/
libCM_LowerName_wallet_a_SOURCES = \
  crypter.cpp \
  db.cpp \
  rpcdump.cpp \
  walletdb.cpp \
  txdb-leveldb.cpp \
  rpcwallet.cpp \
  wallet.cpp \
  scrypt.cpp \
  $(CM_UpperName_CORE_H)

# crypto primitives library
crypto_libCM_LowerName_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_CONFIG_INCLUDES)
crypto_libCM_LowerName_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
crypto_libCM_LowerName_crypto_a_SOURCES = 

# common: shared between CM_LowerNamed, and CM_LowerName-qt and non-server tools
libCM_LowerName_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
libCM_LowerName_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libCM_LowerName_common_a_SOURCES = \
  chainparams.cpp \
  core.cpp \
  hash.cpp \
  key.cpp \
  keystore.cpp \
  netbase.cpp \
  protocol.cpp \
  script.cpp \
  $(CM_UpperName_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libCM_LowerName_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
libCM_LowerName_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libCM_LowerName_util_a_SOURCES = \
  version.cpp \
  rpcprotocol.cpp \
  sync.cpp \
  util.cpp \
  $(CM_UpperName_CORE_H)

if GLIBC_BACK_COMPAT
#libCM_LowerName_util_a_SOURCES += compat/glibc_compat.cpp
endif

# cli: shared between CM_LowerName-cli and CM_LowerName-qt
libCM_LowerName_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
libCM_LowerName_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libCM_LowerName_cli_a_SOURCES = \
  rpcclient.cpp \
  $(CM_UpperName_CORE_H)

nodist_libCM_LowerName_util_a_SOURCES = $(srcdir)/obj/build.h
#

# CM_LowerNamed binary #
CM_LowerNamed_SOURCES = bitcoind.cpp
CM_LowerNamed_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
CM_LowerNamed_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
CM_LowerNamed_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
#CM_LowerNamed_SOURCES += CM_LowerNamed-res.rc
endif

CM_LowerNamed_LDADD = \
  $(LIBCM_UpperName_SERVER) \
  $(LIBCM_UpperName_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBCM_UpperName_UTIL) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)
# retired LDADD
# LIBCM_UpperName_CRYPTO

if ENABLE_ZMQ
CM_LowerNamed_LDADD += $(LIBCM_UpperName_ZMQ) $(ZMQ_LIBS)
endif

if ENABLE_WALLET
#CM_LowerNamed_LDADD += libCM_LowerName_wallet.a
endif

CM_LowerNamed_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS)

# CM_LowerName-cli binary #
CM_LowerName_cli_SOURCES = CM_LowerName-cli.cpp
CM_LowerName_cli_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES) $(EVENT_CFLAGS)
CM_LowerName_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
CM_LowerName_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
CM_LowerName_cli_SOURCES += CM_LowerName-cli-res.rc
endif

CM_LowerName_cli_LDADD = \
  $(LIBCM_UpperName_CLI) \
  $(LIBUNIVALUE) \
  $(LIBCM_UpperName_UTIL)

CM_LowerName_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# CM_LowerName-tx binary #
CM_LowerName_tx_SOURCES = CM_LowerName-tx.cpp
CM_LowerName_tx_CPPFLAGS = $(AM_CPPFLAGS) $(CM_UpperName_INCLUDES)
CM_LowerName_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
CM_LowerName_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
CM_LowerName_tx_SOURCES += CM_LowerName-tx-res.rc
endif

CM_LowerName_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBCM_UpperName_COMMON) \
  $(LIBCM_UpperName_UTIL) \
  $(LIBCM_UpperName_CRYPTO) \
  $(LIBSECP256K1)

CM_LowerName_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# CM_LowerNameconsensus library #
if BUILD_CM_UpperName_LIBS
include_HEADERS =
libCM_LowerNameconsensus_la_SOURCES = \
  hash.cpp \
  script.cpp \
  scrypt.cpp

if GLIBC_BACK_COMPAT
#  libCM_LowerNameconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libCM_LowerNameconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libCM_LowerNameconsensus_la_LIBADD = $(LIBSECP256K1)
libCM_LowerNameconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -DBUILD_CM_UpperName_INTERNAL
libCM_LowerNameconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

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

