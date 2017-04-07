// this is for emacs file handling -*- mode: c++; indent-tabs-mode: nil -*-

// -- BEGIN LICENSE BLOCK ----------------------------------------------
// This file is part of FZIs ic_workspace.
//
// This program is free software licensed under the LGPL
// (GNU LESSER GENERAL PUBLIC LICENSE Version 3).
// You can find a copy of this license in LICENSE folder in the top
// directory of the source code.
//
// © Copyright 2016 FZI Forschungszentrum Informatik, Karlsruhe, Germany
//
// -- END LICENSE BLOCK ------------------------------------------------

//----------------------------------------------------------------------
/*!\file
 *
 * \author  Lars Pfotzer <pfotzer@fzi.de>
 * \author  Klaus Uhl <uhl@fzi.de>
 * \date    2010-02-08
 *
 * \brief   Contains icl_core::thread::RWLockImplPosix
 *
 * \b icl_core::thread::RWLockImplPosix
 */
//----------------------------------------------------------------------
#ifndef ICL_CORE_THREAD_RWLOCK_IMPL_POSIX_H_INCLUDED
#define ICL_CORE_THREAD_RWLOCK_IMPL_POSIX_H_INCLUDED

#include "icl_core/TimeSpan.h"
#include "icl_core/TimeStamp.h"
#include "icl_core_thread/RWLockImpl.h"

namespace icl_core {
namespace thread {

class RWLockImplPosix : public RWLockImpl, protected virtual icl_core::Noncopyable
{
public:
  RWLockImplPosix();
  virtual ~RWLockImplPosix();

  virtual bool readLock();
  virtual bool readLock(const ::icl_core::TimeStamp& timeout);
  virtual bool readLock(const ::icl_core::TimeSpan& timeout);
  virtual bool tryReadLock();

  virtual bool writeLock();
  virtual bool writeLock(const ::icl_core::TimeStamp& timeout);
  virtual bool writeLock(const ::icl_core::TimeSpan& timeout);
  virtual bool tryWriteLock();

  virtual void unlock();

private:
  pthread_rwlock_t *m_rwlock;
};

}
}

#endif
