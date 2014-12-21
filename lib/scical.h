#ifndef __SCICAL_SCICAL_H
#define __SCICAL_SCICAL_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#include "api.h"

#ifdef __cplusplus
}
#endif

#define SCICAL_EXPORT __attribute__((visibility("default")))
#define SCICAL_INLINE __attribute__((always_inline)) inline

#endif
