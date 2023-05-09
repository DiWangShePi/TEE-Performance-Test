/** \file hooks.c
 * \brief An implementation of the PARSEC Hooks Instrumentation API.
 *
 * In this file the hooks library functions are implemented. The hooks API
 * is defined in header file hooks.h.
 *
 * The default functionality can be enabled and disabled by defining the
 * corresponding macros in file config.h. A detailed description of all
 * features is available there.
 */

/* NOTE: A detailed description of each hook function is available in file
 *       hooks.h.
 */

#include "include/hooks.h"
#include "config.h"

#include <stdio.h>
#include <assert.h>

#if ENABLE_TIMING
#include <sys/time.h>
/** \brief Time at beginning of execution of Region-of-Interest.
 *
 * This variable will store the time when the Region-of-Interest is entered.
 * time_begin and time_end allow an accurate measurement of the execution time
 * of the benchmark.
 *
 * Time measurement can be enabled in file config.h.
 */
static double time_begin;
/** \brief Time at end of execution of Region-of-Interest.
 *
 * This variable will store the time when the Region-of-Interest is left.
 * time_begin and time_end allow an accurate measurement of the execution time
 * of the benchmark.
 *
 * Time measurement can be enabled in file config.h.
 */
static double time_end;
#endif // ENABLE_TIMING

#if ENABLE_SETAFFINITY
#include <sched.h>
#include <stdlib.h>
#include <stdbool.h>
#endif // ENABLE_SETAFFINITY

/** Enable debugging code */
#define DEBUG 0

/** \brief Variable for unique identifier of workload.
 *
 * This variable stores the unique identifier of the current benchmark program.
 * It is set in function __parsec_bench_begin().
 */
static enum __parsec_benchmark bench;

/* NOTE: Please look at hooks.h to see how these functions are used */

void __parsec_bench_begin(enum __parsec_benchmark __bench)
{

    fflush(NULL);
#if ENABLE_TIMING
    struct timeval t;
    gettimeofday(&t, NULL);
    time_begin = (double)t.tv_sec + (double)t.tv_usec * 1e-6;
#endif // ENABLE_TIMING
}

void __parsec_bench_end()
{
#if ENABLE_TIMING
    struct timeval t;
    gettimeofday(&t, NULL);
    time_end = (double)t.tv_sec + (double)t.tv_usec * 1e-6;
    printf(HOOKS_PREFIX " Total time spent: %.3fs\n", time_end - time_begin);
#endif // ENABLE_TIMING
}

void __parsec_roi_begin()
{
}

void __parsec_roi_end()
{
}